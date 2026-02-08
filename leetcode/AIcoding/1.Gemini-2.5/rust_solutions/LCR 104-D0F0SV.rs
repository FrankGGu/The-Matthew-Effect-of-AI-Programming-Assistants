impl Solution {
    pub fn combination_sum4(nums: Vec<i32>, target: i32) -> i32 {
        let target_usize = target as usize;
        let mut dp = vec![0; target_usize + 1];
        dp[0] = 1;

        for i in 1..=target_usize {
            for &num in nums.iter() {
                let num_usize = num as usize;
                if i >= num_usize {
                    dp[i] += dp[i - num_usize];
                }
            }
        }

        dp[target_usize]
    }
}