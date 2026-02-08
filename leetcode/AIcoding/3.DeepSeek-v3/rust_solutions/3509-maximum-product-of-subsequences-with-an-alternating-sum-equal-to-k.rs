impl Solution {
    pub fn maximum_product(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut dp = vec![vec![None; (k + 1) as usize]; n + 1];
        dp[0][0] = Some(1);

        for i in 0..n {
            for j in 0..=k as usize {
                if let Some(val) = dp[i][j] {
                    // Not take nums[i]
                    if let Some(existing) = dp[i + 1][j] {
                        if val > existing {
                            dp[i + 1][j] = Some(val);
                        }
                    } else {
                        dp[i + 1][j] = Some(val);
                    }

                    // Take nums[i]
                    let new_j = j as i32 + if i % 2 == 0 { nums[i] } else { -nums[i] };
                    if new_j >= 0 && new_j <= k {
                        let new_j = new_j as usize;
                        if let Some(existing) = dp[i + 1][new_j] {
                            if val * nums[i] > existing {
                                dp[i + 1][new_j] = Some(val * nums[i]);
                            }
                        } else {
                            dp[i + 1][new_j] = Some(val * nums[i]);
                        }
                    }
                }
            }
        }

        dp[n][k as usize].unwrap_or(0) % 1_000_000_007
    }
}