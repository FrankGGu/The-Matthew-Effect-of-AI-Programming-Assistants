impl Solution {
    pub fn max_size_slices(slices: Vec<i32>) -> i32 {
        let n = slices.len();
        let m = n / 3;

        fn solve(slices: &[i32], m: usize) -> i32 {
            let n = slices.len();
            let mut dp = vec![vec![0; m + 1]; n + 1];

            for i in 1..=n {
                for j in 1..=m {
                    dp[i][j] = dp[i - 1][j].max(slices[i - 1] + if i >= 2 { dp[i - 2][j - 1] } else { 0 });
                }
            }

            dp[n][m]
        }

        solve(&slices[..(n - 1)], m).max(solve(&slices[1..], m))
    }
}