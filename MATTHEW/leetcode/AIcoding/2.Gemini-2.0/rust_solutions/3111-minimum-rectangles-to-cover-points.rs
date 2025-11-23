impl Solution {
    pub fn min_rectangles_to_cover_points(points: Vec<Vec<i32>>) -> i32 {
        let n = points.len();
        if n == 0 {
            return 0;
        }

        let mut dp = vec![std::i32::MAX; 1 << n];
        dp[0] = 0;

        for mask in 0..(1 << n) {
            if dp[mask] == std::i32::MAX {
                continue;
            }

            for i in 0..n {
                if (mask & (1 << i)) == 0 {
                    for j in (i + 1)..n {
                        if (mask & (1 << j)) == 0 {
                            dp[mask | (1 << i) | (1 << j)] = dp[mask | (1 << i) | (1 << j)].min(dp[mask] + 1);

                            for k in (j + 1)..n {
                                if (mask & (1 << k)) == 0 {
                                    dp[mask | (1 << i) | (1 << j) | (1 << k)] = dp[mask | (1 << i) | (1 << j) | (1 << k)].min(dp[mask] + 1);
                                }
                            }
                            break;
                        }
                    }
                    dp[mask | (1 << i)] = dp[mask | (1 << i)].min(dp[mask] + 1);
                    break;
                }
            }
        }

        dp[(1 << n) - 1]
    }
}