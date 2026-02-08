impl Solution {
    pub fn maximize_the_minimum_game_score(nums: Vec<i32>, k: i32) -> i64 {
        let n = nums.len();
        let mut prefix_sums: Vec<i64> = vec![0; n + 1];
        for i in 0..n {
            prefix_sums[i + 1] = prefix_sums[i] + nums[i] as i64;
        }

        let mut dp: Vec<Vec<i64>> = vec![vec![0; n + 1]; (k + 1) as usize];

        for i in 1..=(k as usize) {
            for j in i..=n {
                if i == 1 {
                    dp[i][j] = prefix_sums[j];
                } else {
                    dp[i][j] = 0;
                    for x in (i - 1)..j {
                        dp[i][j] = dp[i][j].max(dp[i - 1][x].min(prefix_sums[j] - prefix_sums[x]));
                    }
                }
            }
        }

        dp[k as usize][n]
    }
}