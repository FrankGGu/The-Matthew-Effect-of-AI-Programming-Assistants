impl Solution {
    pub fn prime_subtraction_operation(n: i32) -> bool {
        let mut is_prime = vec![true; n as usize + 1];
        is_prime[0] = false;
        is_prime[1] = false;

        for i in 2..=n as usize {
            if is_prime[i] {
                let mut j = 2 * i;
                while j <= n as usize {
                    is_prime[j] = false;
                    j += i;
                }
            }
        }

        let primes: Vec<i32> = (2..=n).filter(|&x| is_prime[x as usize]).collect();
        let mut dp = vec![false; (n + 1) as usize];
        dp[0] = true;

        for p in primes {
            for j in (p..=n).rev() {
                dp[j as usize] = dp[j as usize] || dp[(j - p) as usize];
            }
        }

        dp[n as usize]
    }
}