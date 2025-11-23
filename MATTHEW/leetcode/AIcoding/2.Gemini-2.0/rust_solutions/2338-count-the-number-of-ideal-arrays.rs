const MOD: i64 = 1_000_000_007;

impl Solution {
    pub fn ideal_arrays(n: i32, max_value: i32) -> i32 {
        let n = n as usize;
        let max_value = max_value as usize;

        let mut c = vec![vec![0; n + 1]; max_value + 1];
        for i in 0..=max_value {
            c[i][0] = 1;
        }
        for i in 1..=max_value {
            for j in 1..=n {
                c[i][j] = (c[i - 1][j - 1] + c[i - 1][j]) % MOD;
            }
        }

        let mut ans = 0;
        for i in 1..=max_value {
            let mut cnt = 0;
            let mut d = i;
            let mut j = 2;
            while j * j <= d {
                if d % j == 0 {
                    cnt += 1;
                    while d % j == 0 {
                        d /= j;
                    }
                }
                j += 1;
            }
            if d > 1 {
                cnt += 1;
            }

            ans = (ans + c[cnt + n - 1][n - 1]) % MOD;
        }

        ans as i32
    }
}