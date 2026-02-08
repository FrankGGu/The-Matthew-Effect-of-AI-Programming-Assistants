impl Solution {
    pub fn merge_stones(stones: Vec<i32>, k: i32) -> i32 {
        let n = stones.len();
        if n == 1 {
            return 0;
        }
        if (n - 1) % (k - 1) != 0 {
            return -1;
        }

        let mut dp = vec![vec![0; n]; n];
        let mut sum = vec![0; n + 1];

        for i in 0..n {
            sum[i + 1] = sum[i] + stones[i];
        }

        for length in (1..=n).rev() {
            for i in 0..=n - length {
                let j = i + length - 1;
                if length == 1 {
                    dp[i][j] = 0;
                } else {
                    dp[i][j] = i32::MAX;
                    for m in 1..length / (k - 1) {
                        let mid = i + m * (k - 1);
                        if mid <= j {
                            dp[i][j] = dp[i][j].min(dp[i][mid - 1] + dp[mid][j]);
                        }
                    }
                    if (length - 1) % (k - 1) == 0 {
                        dp[i][j] += sum[j + 1] - sum[i];
                    }
                }
            }
        }

        dp[0][n - 1]
    }
}