use std::collections::HashSet;

impl Solution {
    pub fn distinct_prime_factors(nums: Vec<i32>) -> i32 {
        let mut primes = HashSet::new();
        for &num in &nums {
            let mut n = num;
            let mut i = 2;
            while i * i <= n {
                if n % i == 0 {
                    primes.insert(i);
                    while n % i == 0 {
                        n /= i;
                    }
                }
                i += 1;
            }
            if n > 1 {
                primes.insert(n);
            }
        }
        primes.len() as i32
    }
}