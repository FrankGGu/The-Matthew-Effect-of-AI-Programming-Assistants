impl Solution {
    pub fn min_cost(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut dp = vec![0; n + 1];
        let mut last = vec![-1; 10001];
        let mut freq = vec![0; 10001];

        for i in 1..=n {
            dp[i] = dp[i - 1] + 1;
            freq[nums[i - 1] as usize] += 1;
            if freq[nums[i - 1] as usize] == 1 {
                dp[i] = dp[i].min(dp[i - 1] + 1);
            }
            if i >= k as usize {
                let prev = last[nums[i - 1] as usize];
                if prev != -1 {
                    dp[i] = dp[i].min(dp[prev as usize] + (i - prev as usize - 1));
                }
            }
            last[nums[i - 1] as usize] = i as i32;
        }

        dp[n] - 1
    }
}