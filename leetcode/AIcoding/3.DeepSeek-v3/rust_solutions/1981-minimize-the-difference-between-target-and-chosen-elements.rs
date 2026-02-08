impl Solution {
    pub fn minimize_the_difference(mat: Vec<Vec<i32>>, target: i32) -> i32 {
        let m = mat.len();
        let n = mat[0].len();
        let max_sum: i32 = mat.iter().map(|row| row.iter().max().unwrap()).sum();
        let mut dp = vec![vec![false; (max_sum + 1) as usize]; m + 1];
        dp[0][0] = true;

        for i in 1..=m {
            for j in 0..=max_sum as usize {
                if dp[i - 1][j] {
                    for &num in &mat[i - 1] {
                        let sum = j + num as usize;
                        if sum <= max_sum as usize {
                            dp[i][sum] = true;
                        }
                    }
                }
            }
        }

        let mut min_diff = i32::MAX;
        for sum in 0..=max_sum as usize {
            if dp[m][sum] {
                let diff = (sum as i32 - target).abs();
                if diff < min_diff {
                    min_diff = diff;
                }
            }
        }

        min_diff
    }
}