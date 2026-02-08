impl Solution {
    pub fn distinct_prime_factors(nums: Vec<i32>) -> i32 {
        use std::collections::HashSet;

        let mut primes = HashSet::new();

        for &num in nums.iter() {
            let mut n = num;
            let mut i = 2;
            while i * i <= n {
                while n % i == 0 {
                    primes.insert(i);
                    n /= i;
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