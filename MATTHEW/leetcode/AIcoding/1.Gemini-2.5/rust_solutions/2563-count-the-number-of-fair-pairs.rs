impl Solution {
    pub fn count_fair_pairs(mut nums: Vec<i32>, lower: i32, upper: i32) -> i64 {
        nums.sort_unstable();
        let n = nums.len();

        fn count_pairs_le(nums: &[i32], target: i32) -> i64 {
            let n = nums.len();
            let mut count = 0;
            let mut left = 0;
            let mut right = n - 1;

            while left < right {
                // Cast to i64 to prevent potential overflow during sum calculation,
                // although for the given constraints, i32 sum would fit.
                // It's a good practice for range sum problems.
                if (nums[left] as i64) + (nums[right] as i64) <= target as i64 {
                    // All pairs (nums[left], nums[k]) where left < k <= right
                    // will have a sum less than or equal to target,
                    // because nums[k] <= nums[right] due to sorting.
                    count += (right - left) as i64;
                    left += 1;
                } else {
                    // nums[left] + nums[right] is too large,
                    // so we need a smaller nums[right].
                    right -= 1;
                }
            }
            count
        }

        let count_upper = count_pairs_le(&nums, upper);
        let count_lower_minus_1 = count_pairs_le(&nums, lower - 1);

        count_upper - count_lower_minus_1
    }
}