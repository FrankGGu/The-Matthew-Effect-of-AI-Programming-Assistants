struct Solution;

impl Solution {
    pub fn smallest_distance_pair(nums: Vec<i32>, k: i32) -> i32 {
        let mut nums = nums;
        nums.sort();

        let mut left = 0;
        let mut right = nums[nums.len() - 1] - nums[0];

        while left < right {
            let mid = left + (right - left) / 2;
            let mut count = 0;
            let mut j = 0;

            for i in 0..nums.len() {
                while j < nums.len() && nums[j] - nums[i] > mid {
                    j += 1;
                }
                count += j - i;
            }

            if count < k {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        left
    }
}