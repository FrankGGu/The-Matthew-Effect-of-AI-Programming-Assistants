impl Solution {
    pub fn min_cost(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut dp = vec![i32::MAX; n + 1];
        dp[0] = 0;

        for i in 1..=n {
            let mut freq = std::collections::HashMap::new();
            let mut cost = 0;
            for j in (1..=k).rev() {
                if i - j < 0 { break; }
                let x = nums[i - j];
                *freq.entry(x).or_insert(0) += 1;
                if freq[x] == 1 {
                    cost += 1;
                } else if freq[x] == 2 {
                    cost -= 1;
                }
                dp[i] = dp[i].min(dp[i - j] + cost);
            }
        }

        dp[n]
    }
}