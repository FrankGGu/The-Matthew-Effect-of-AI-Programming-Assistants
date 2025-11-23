impl Solution {
    pub fn stone_game_vii(stones: Vec<i32>) -> i32 {
        let n = stones.len();
        let mut prefix = vec![0; n + 1];
        for i in 0..n {
            prefix[i + 1] = prefix[i] + stones[i];
        }
        let mut dp = vec![vec![0; n]; n];
        for len in 2..=n {
            for i in 0..=n - len {
                let j = i + len - 1;
                let sum_left = prefix[j + 1] - prefix[i + 1];
                let sum_right = prefix[j] - prefix[i];
                dp[i][j] = (sum_left - dp[i + 1][j]).max(sum_right - dp[i][j - 1]);
            }
        }
        dp[0][n - 1]
    }
}