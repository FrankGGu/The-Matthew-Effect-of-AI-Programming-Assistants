impl Solution {
    pub fn number_of_arrays(a: Vec<i32>, k: i32) -> i32 {
        let n = a.len();
        let k_len = k.to_string().len();
        let mod_val = 1_000_000_007;
        let mut dp = vec![0; n + 1];
        dp[n] = 1;

        for i in (0..n).rev() {
            if a[i] == 0 {
                continue;
            }
            let mut num = 0i64;
            for j in i..n {
                num = num * 10 + a[j] as i64;
                if num > k as i64 {
                    break;
                }
                dp[i] = (dp[i] + dp[j + 1]) % mod_val;
            }
        }

        dp[0] as i32
    }
}