impl Solution {
    pub fn min_cost(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut dp = vec![0; n + 1];
        let mut freq = vec![0; 101];

        for i in 1..=n {
            let mut unique_count = 0;
            dp[i] = dp[i - 1] + k;
            for j in i - 1..=0 {
                if freq[nums[j] as usize] == 0 {
                    unique_count += 1;
                }
                freq[nums[j] as usize] += 1;
                dp[i] = dp[i].min(dp[j] + k + unique_count);
            }
            for j in i - 1..=0 {
                freq[nums[j] as usize] -= 1;
            }
        }
        dp[n]
    }
}