impl Solution {
    pub fn fill_grid(n: i32, m: i32, k: i32) -> i32 {
        let n = n as i64;
        let m = m as i64;
        let k = k as i64;
        let mod_val = 1_000_000_007;

        if k == 0 {
            return Solution::pow(2, n + m, mod_val) as i32;
        }

        let mut dp = vec![vec![0; (k + 1) as usize]; (n + 1) as usize];
        dp[0][0] = 1;

        for i in 1..=n {
            for j in 0..=k {
                dp[i as usize][j as usize] = dp[(i - 1) as usize][j as usize] * 2 % mod_val;
                if j > 0 {
                    dp[i as usize][j as usize] = (dp[i as usize][j as usize] + dp[(i - 1) as usize][(j - 1) as usize]) % mod_val;
                }
            }
        }

        let n_ways = dp[n as usize][k as usize];

        dp = vec![vec![0; (k + 1) as usize]; (m + 1) as usize];
        dp[0][0] = 1;

        for i in 1..=m {
            for j in 0..=k {
                dp[i as usize][j as usize] = dp[(i - 1) as usize][j as usize] * 2 % mod_val;
                if j > 0 {
                    dp[i as usize][j as usize] = (dp[i as usize][j as usize] + dp[(i - 1) as usize][(j - 1) as usize]) % mod_val;
                }
            }
        }

        let m_ways = dp[m as usize][k as usize];

        (n_ways * m_ways % mod_val) as i32
    }

    fn pow(mut base: i64, mut exp: i64, mod_val: i64) -> i64 {
        let mut res = 1;
        base %= mod_val;
        while exp > 0 {
            if exp % 2 == 1 {
                res = (res * base) % mod_val;
            }
            base = (base * base) % mod_val;
            exp /= 2;
        }
        res
    }
}