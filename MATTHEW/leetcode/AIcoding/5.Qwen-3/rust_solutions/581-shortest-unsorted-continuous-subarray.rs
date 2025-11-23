impl Solution {

use std::cmp;

impl Solution {
    pub fn find_unsorted_subarray(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n <= 1 {
            return 0;
        }

        let mut left = 0;
        let mut right = n - 1;

        while left < n - 1 && nums[left] <= nums[left + 1] {
            left += 1;
        }

        if left == n - 1 {
            return 0;
        }

        while right > 0 && nums[right] >= nums[right - 1] {
            right -= 1;
        }

        let mut min_val = nums[left];
        let mut max_val = nums[left];

        for i in left..=right {
            min_val = cmp::min(min_val, nums[i]);
            max_val = cmp::max(max_val, nums[i]);
        }

        while left > 0 && nums[left - 1] > min_val {
            left -= 1;
        }

        while right < n - 1 && nums[right + 1] < max_val {
            right += 1;
        }

        (right - left + 1) as i32
    }
}
}