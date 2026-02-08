impl Solution {
    pub fn min_cost(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut dp = vec![0; n + 1];
        for i in 1..=n {
            dp[i] = dp[i - 1] + k;
            for j in (1..=i).rev() {
                let mut count = std::collections::HashMap::new();
                let mut cost = 0;
                for l in j..=i {
                    *count.entry(nums[l - 1]).or_insert(0) += 1;
                    if count[&nums[l - 1]] == 2 {
                        cost += 2;
                    } else if count[&nums[l - 1]] > 2 {
                        cost += 1;
                    }
                }
                dp[i] = dp[i].min(dp[j - 1] + k + cost);
            }
        }
        dp[n]
    }
}