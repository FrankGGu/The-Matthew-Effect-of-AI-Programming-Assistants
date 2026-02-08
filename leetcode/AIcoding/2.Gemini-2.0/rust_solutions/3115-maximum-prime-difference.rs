impl Solution {
    pub fn maximum_prime_difference(nums: Vec<i32>) -> i32 {
        let mut primes = Vec::new();
        for &num in &nums {
            if num > 1 {
                let mut is_prime = true;
                for &p in &primes {
                    if p * p > num {
                        break;
                    }
                    if num % p == 0 {
                        is_prime = false;
                        break;
                    }
                }
                if is_prime {
                    let mut is_real_prime = true;
                    for i in 2..=((num as f64).sqrt() as i32) {
                        if num % i == 0 {
                            is_real_prime = false;
                            break;
                        }
                    }

                    if is_real_prime {
                        primes.push(num);
                    }
                }
            }
        }

        primes.sort();

        if primes.len() < 2 {
            return -1;
        }

        primes[primes.len() - 1] - primes[0]
    }
}