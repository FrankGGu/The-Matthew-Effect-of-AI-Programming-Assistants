impl Solution {
    pub fn maximum_prime_difference(nums: Vec<i32>) -> i32 {
        let is_prime = |n: i32| {
            if n < 2 {
                return false;
            }
            for i in 2..=((n as f64).sqrt() as i32) {
                if n % i == 0 {
                    return false;
                }
            }
            true
        };

        let mut primes = vec![];
        for &num in &nums {
            if is_prime(num) {
                primes.push(num);
            }
        }

        if primes.is_empty() {
            return 0;
        }

        let min_prime = *primes.iter().min().unwrap();
        let max_prime = *primes.iter().max().unwrap();
        (max_prime - min_prime) as i32
    }
}