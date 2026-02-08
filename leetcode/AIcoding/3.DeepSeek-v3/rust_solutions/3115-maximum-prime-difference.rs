impl Solution {
    pub fn maximum_prime_difference(nums: Vec<i32>) -> i32 {
        fn is_prime(n: i32) -> bool {
            if n <= 1 {
                return false;
            }
            if n == 2 {
                return true;
            }
            if n % 2 == 0 {
                return false;
            }
            let mut i = 3;
            while i * i <= n {
                if n % i == 0 {
                    return false;
                }
                i += 2;
            }
            true
        }

        let mut primes_indices = Vec::new();
        for (i, &num) in nums.iter().enumerate() {
            if is_prime(num) {
                primes_indices.push(i as i32);
            }
        }

        if primes_indices.len() < 2 {
            return 0;
        }

        primes_indices.last().unwrap() - primes_indices[0]
    }
}