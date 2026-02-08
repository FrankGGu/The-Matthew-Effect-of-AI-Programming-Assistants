impl Solution {
    pub fn count_prime_set_bits(left: i32, right: i32) -> i32 {
        let primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31];
        (left..=right).filter(|&x| {
            let bits = x.count_ones() as i32;
            primes.contains(&bits)
        }).count() as i32
    }
}