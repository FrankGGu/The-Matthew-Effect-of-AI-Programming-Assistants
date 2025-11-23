use std::cmp::Ordering;

impl Solution {
    pub fn minimize_the_difference(mat: Vec<Vec<i32>>, target: i32) -> i32 {
        let m = mat.len();
        let n = mat[0].len();
        let mut dp = vec![i32::MAX; 5001];
        dp[0] = 0;

        for row in mat {
            let mut new_dp = dp.clone();
            for &num in &row {
                for j in (0..=5000).rev() {
                    if dp[j] != i32::MAX {
                        let new_sum = j + num;
                        if new_sum <= 5000 {
                            new_dp[new_sum as usize] = new_dp[new_sum as usize].min(dp[j] + num);
                        }
                    }
                }
            }
            dp = new_dp;
        }

        let mut min_diff = i32::MAX;
        for i in 0..=5000 {
            if dp[i as usize] != i32::MAX {
                min_diff = min_diff.min((target - i).abs());
            }
        }
        min_diff
    }
}