impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn prime_pairs_with_target_sum(n: i32) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        let mut primes = HashSet::new();
        let mut is_prime = vec![true; (n + 1) as usize];
        is_prime[0] = false;
        is_prime[1] = false;

        for i in 2..=(n as f64).sqrt() as i32 {
            if is_prime[i as usize] {
                for j in (i * i)..=n {
                    is_prime[j as usize] = false;
                }
            }
        }

        for i in 2..=n {
            if is_prime[i as usize] {
                primes.insert(i);
            }
        }

        for &p in &primes {
            let complement = n - p;
            if primes.contains(&complement) && p <= complement {
                result.push(vec![p, complement]);
            }
        }

        result
    }
}
}