impl Solution {
    pub fn rune_reserve(nums: Vec<i33>) -> i64 {
        let n = nums.len();
        if n < 3 {
            return 0;
        }

        let mut nums = nums;
        nums.sort_unstable();

        let mut max_sum: i64 = 0;
        let mut left = 0;

        for right in 0..n {
            while nums[right] - nums[left] > 2 {
                left += 1;
            }

            if right - left + 1 >= 3 {
                let current_sum = nums[right] as i64 + nums[right - 1] as i64 + nums[right - 2] as i64;
                max_sum = max_sum.max(current_sum);
            }
        }

        max_sum
    }
}