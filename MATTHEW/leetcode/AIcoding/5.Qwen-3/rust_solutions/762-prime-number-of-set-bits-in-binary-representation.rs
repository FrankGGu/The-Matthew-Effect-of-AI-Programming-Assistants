struct Solution;

impl Solution {
    pub fn count_prime_set_bits(mut left: i32, mut right: i32) -> i32 {
        let primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31];
        let mut count = 0;
        while left <= right {
            let bits = left.count_ones();
            if primes.contains(&bits) {
                count += 1;
            }
            left += 1;
        }
        count
    }
}