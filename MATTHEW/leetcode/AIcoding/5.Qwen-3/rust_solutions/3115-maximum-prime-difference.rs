impl Solution {

use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn max_prime_difference(nums: Vec<i32>) -> i32 {
        let mut primes = HashSet::new();
        let max_num = *nums.iter().max().unwrap();

        let mut is_prime = vec![true; (max_num + 1) as usize];
        is_prime[0] = false;
        is_prime[1] = false;

        for i in 2..=((max_num as f64).sqrt() as i32) {
            if is_prime[i as usize] {
                for j in (i * i)..=max_num {
                    is_prime[j as usize] = false;
                }
            }
        }

        for &num in &nums {
            if is_prime[num as usize] {
                primes.insert(num);
            }
        }

        let mut primes: Vec<i32> = primes.into_iter().collect();
        primes.sort();

        if primes.len() < 2 {
            0
        } else {
            primes.last().unwrap() - primes.first().unwrap()
        }
    }
}
}