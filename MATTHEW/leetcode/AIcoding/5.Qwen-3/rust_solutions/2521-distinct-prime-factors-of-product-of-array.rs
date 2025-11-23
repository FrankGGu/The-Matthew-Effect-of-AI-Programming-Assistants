impl Solution {

use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn distinct_prime_factors(mut nums: Vec<i32>) -> i32 {
        let mut primes = HashSet::new();
        let mut n = 2;
        while n * n <= nums.iter().max().unwrap() {
            if nums.iter().any(|&x| x % n == 0) {
                primes.insert(n);
                for i in 0..nums.len() {
                    while nums[i] % n == 0 {
                        nums[i] /= n;
                    }
                }
            }
            n += 1;
        }
        for &num in &nums {
            if num > 1 {
                primes.insert(num);
            }
        }
        primes.len() as i32
    }
}
}