impl Solution {

use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn num_prime_arrangements(n: i32) -> i32 {
        let mut is_prime = vec![true; (n + 1) as usize];
        is_prime[0] = false;
        is_prime[1] = false;

        for i in 2..=((n as f64).sqrt() as i32) {
            if is_prime[i as usize] {
                for j in (i * i)..=n {
                    if j % i == 0 {
                        is_prime[j as usize] = false;
                    }
                }
            }
        }

        let prime_count = is_prime.iter().filter(|&&x| x).count();
        let non_prime_count = n as usize - prime_count;

        let mut factorial = vec![1; n as usize + 1];

        for i in 1..=n as usize {
            factorial[i] = factorial[i - 1] * i as i32;
        }

        factorial[prime_count] * factorial[non_prime_count]
    }
}
}