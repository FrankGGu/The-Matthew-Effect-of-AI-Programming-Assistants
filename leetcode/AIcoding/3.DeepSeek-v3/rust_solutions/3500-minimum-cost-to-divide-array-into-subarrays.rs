impl Solution {
    pub fn min_cost(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut dp = vec![std::i32::MAX; n + 1];
        dp[0] = 0;

        for i in 1..=n {
            let mut freq = std::collections::HashMap::new();
            let mut cost = 0;

            for j in (0..i).rev() {
                let num = nums[j];
                *freq.entry(num).or_insert(0) += 1;
                if freq[&num] == 2 {
                    cost += 2;
                } else if freq[&num] > 2 {
                    cost += 1;
                }

                dp[i] = dp[i].min(dp[j] + k + cost);
            }
        }

        dp[n]
    }
}