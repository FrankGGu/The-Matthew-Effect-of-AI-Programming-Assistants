impl Solution {

use std::cmp;

impl Solution {
    pub fn min_subarray_len(nums: Vec<i32>, target: i32) -> i32 {
        let n = nums.len();
        let mut left = 0;
        let mut current_sum = 0;
        let mut min_length = i32::MAX;

        for right in 0..n {
            current_sum += nums[right];

            while current_sum > target {
                current_sum -= nums[left];
                left += 1;
            }

            if current_sum == target {
                min_length = cmp::min(min_length, (right - left + 1) as i32);
            }
        }

        if min_length == i32::MAX {
            -1
        } else {
            min_length
        }
    }

    pub fn find_buildings(nums: Vec<i32>, target: i32) -> Vec<i32> {
        let n = nums.len();
        let mut result = Vec::new();
        let mut left = 0;
        let mut current_sum = 0;

        for right in 0..n {
            current_sum += nums[right];

            while current_sum > target {
                current_sum -= nums[left];
                left += 1;
            }

            if current_sum == target {
                result.push(left as i32);
                result.push(right as i32);
                return result;
            }
        }

        vec![]
    }

    pub fn min_sum_of_two_subarrays(nums: Vec<i32>, target: i32) -> i32 {
        let n = nums.len();
        let mut prefix_min = vec![i32::MAX; n];
        let mut suffix_min = vec![i32::MAX; n];

        let mut current_sum = 0;
        let mut min_len = i32::MAX;
        let mut left = 0;

        for right in 0..n {
            current_sum += nums[right];

            while current_sum > target {
                current_sum -= nums[left];
                left += 1;
            }

            if current_sum == target {
                min_len = cmp::min(min_len, (right - left + 1) as i32);
                prefix_min[right] = min_len;
            } else {
                prefix_min[right] = prefix_min[right - 1];
            }
        }

        current_sum = 0;
        left = n - 1;
        min_len = i32::MAX;

        for right in (0..n).rev() {
            current_sum += nums[right];

            while current_sum > target {
                current_sum -= nums[left];
                left -= 1;
            }

            if current_sum == target {
                min_len = cmp::min(min_len, (left - right + 1) as i32);
                suffix_min[right] = min_len;
            } else {
                suffix_min[right] = suffix_min[right + 1];
            }
        }

        let mut result = i32::MAX;

        for i in 0..n - 1 {
            if prefix_min[i] != i32::MAX && suffix_min[i + 1] != i32::MAX {
                result = cmp::min(result, prefix_min[i] + suffix_min[i + 1]);
            }
        }

        if result == i32::MAX {
            -1
        } else {
            result
        }
    }
}
}