impl Solution {
    pub fn maximum_and_sum(nums: Vec<i32>, num_slots: i32) -> i32 {
        let n = nums.len();
        let mut dp = vec![0; 1 << num_slots];

        for &num in &nums {
            for mask in (0..1 << num_slots).rev() {
                for i in 0..num_slots {
                    if mask & (1 << i) == 0 {
                        let new_mask = mask | (1 << i);
                        dp[new_mask] = dp[new_mask].max(dp[mask] + (num & (1 << i)));
                    }
                }
            }
        }

        *dp.iter().max().unwrap()
    }
}