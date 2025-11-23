impl Solution {
    pub fn count_balanced_permutations(n: i32) -> i32 {
        let mod_val = 1_000_000_007;
        let n = n as usize;
        let mut dp = vec![0; n + 1];
        dp[0] = 1;

        for i in 1..=n {
            dp[i] = dp[i - 1] * (2 * i - 1) % mod_val;
        }

        dp[n] * factorial(n) % mod_val
    }
}

fn factorial(n: usize) -> i32 {
    let mut result = 1;
    for i in 2..=n {
        result = (result * i as i32) % 1_000_000_007;
    }
    result
}