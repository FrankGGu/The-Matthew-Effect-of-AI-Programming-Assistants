use std::collections::HashSet;

pub fn distinct_prime_factors(nums: Vec<i32>) -> i32 {
    let mut primes = HashSet::new();

    for &num in &nums {
        let mut n = num;
        let mut factor = 2;
        while n > 1 {
            if n % factor == 0 {
                primes.insert(factor);
                while n % factor == 0 {
                    n /= factor;
                }
            }
            factor += 1;
            if factor * factor > num {
                if n > 1 {
                    primes.insert(n);
                }
                break;
            }
        }
    }

    primes.len() as i32
}