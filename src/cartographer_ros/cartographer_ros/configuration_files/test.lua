-- Copyright 2016 The Cartographer Authors
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

include "map_builder.lua"
include "trajectory_builder.lua"

options = {
  map_builder = MAP_BUILDER,
  trajectory_builder = TRAJECTORY_BUILDER,
  map_frame = "map",
  tracking_frame = "imu_link",  --有imu的link就设置成imu的link 没有就设置成base_link
  published_frame = "odom", --cartographer发布的tf的最下边一个坐标系，也就是bag文件中tf树最上边的坐标系
  odom_frame = "odom",
  provide_odom_frame = false,--是否提供里程计 如果bag中有就为false 如果没有根据需要获取
  publish_frame_projected_to_2d = true,
  use_pose_extrapolator = true,--不管什么时候都false
  use_odometry = false,--是否使用里程计传感器数据  好像carto会发布 是否使用里程计的传感器数据 如果为true。tf树中一定存在odom这个坐标系
  use_nav_sat = false,--是否使用gps数据  默认fix
  use_landmarks = false,

  num_laser_scans = 0,--单线点云数量
  num_multi_echo_laser_scans = 0,--多回声波雷达
  num_subdivisions_per_laser_scan = 1,--默认为1
  num_point_clouds = 1,--多线点云数量 （和单线点云数量）可以同时为1不能同时为0

  lookup_transform_timeout_sec = 0.2,
  submap_publish_period_sec = 0.3,
  pose_publish_period_sec = 5e-3,
  trajectory_publish_period_sec = 30e-3,
  rangefinder_sampling_ratio = 1.,
  odometry_sampling_ratio = 1.,
  fixed_frame_pose_sampling_ratio = 1.,
  imu_sampling_ratio = 1.,
  landmarks_sampling_ratio = 1.,
}

MAP_BUILDER.use_trajectory_builder_2d = true
TRAJECTORY_BUILDER_2D.use_imu_data = false --是否使用imu，如果用imu，tracking_frame一定要设置成imu的link
TRAJECTORY_BUILDER_2D.min_z= 0.6 --点云的最小z的范围，单线点云不能设置大于0的值（不设置），多线点云的这个值要大于0
return options
