impl Solution {

use std::cmp::min;

impl Solution {
    pub fn value_of_beauty(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut left_min = vec![0; n];
        let mut right_max = vec![0; n];

        left_min[0] = nums[0];
        for i in 1..n {
            left_min[i] = min(left_min[i - 1], nums[i]);
        }

        right_max[n - 1] = nums[n - 1];
        for i in (0..n - 1).rev() {
            right_max[i] = max(right_max[i + 1], nums[i]);
        }

        let mut beauty_sum = 0;
        for i in 1..n - 1 {
            if nums[i] > left_min[i] && nums[i] < right_max[i] {
                beauty_sum += 1;
            }
        }

        beauty_sum
    }
}
}