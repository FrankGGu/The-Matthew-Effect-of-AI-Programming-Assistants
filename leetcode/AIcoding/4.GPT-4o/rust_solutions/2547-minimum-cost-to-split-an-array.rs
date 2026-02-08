impl Solution {
    pub fn minimum_cost(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut dp = vec![i32::MAX; n + 1];
        dp[0] = 0;

        for i in 1..=n {
            let mut seen = std::collections::HashSet::new();
            let mut cost = 0;
            for j in (1..=i).rev() {
                if seen.insert(nums[j - 1]) {
                    cost += 1;
                }
                dp[i] = dp[i].min(dp[j - 1] + cost + k);
            }
        }
        dp[n] - k
    }
}