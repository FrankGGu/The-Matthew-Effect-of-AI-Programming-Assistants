impl Solution {
    pub fn find_all_possible_stable_arrays(n: i32, k: i32) -> i32 {
        if k == 0 {
            return 1;
        }
        if n == 1 {
            return if k == 0 { 1 } else { 0 };
        }
        if n == 2 {
            return if k <= 1 { 1 } else { 0 };
        }
        if k > n * (n - 1) / 2 {
            return 0;
        }

        let n = n as usize;
        let k = k as usize;

        let mut dp = vec![vec![0; k + 1]; n + 1];

        dp[1][0] = 1;
        for i in 2..=n {
            for j in 0..=k {
                for l in 0..=std::cmp::min(j, i - 1) {
                    dp[i][j] += dp[i - 1][j - l];
                }
            }
        }

        dp[n][k]
    }
}