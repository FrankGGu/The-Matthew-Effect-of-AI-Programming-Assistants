impl Solution {
    pub fn max_score(nums: Vec<i32>, quantity: Vec<i32>) -> i64 {
        let n = nums.len();
        let m = quantity.len();
        let mut counts = vec![];
        for i in 0..m {
            for _j in 0..quantity[i] {
                counts.push(i);
            }
        }
        counts.sort();
        let k = counts.len();
        nums.sort();

        let mut dp = vec![vec![i64::MIN; k + 1]; n + 1];
        dp[0][0] = 0;

        for i in 1..=n {
            for j in 0..=k.min(i) {
                dp[i][j] = dp[i - 1][j];
                if j > 0 {
                    dp[i][j] = dp[i][j].max(dp[i - 1][j - 1] + (nums[n - i] as i64) * (counts[j - 1] as i64 + 1));
                }
            }
        }

        dp[n][k]
    }
}