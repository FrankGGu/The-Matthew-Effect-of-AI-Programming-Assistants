impl Solution {
    pub fn count_prime_set_bits(left: i32, right: i32) -> i32 {
        let is_prime = |num: i32| {
            if num < 2 { return false; }
            for i in 2..=((num as f64).sqrt() as i32) {
                if num % i == 0 {
                    return false;
                }
            }
            true
        };

        (left..=right).filter(|&num| {
            let count = num.count_ones();
            is_prime(count)
        }).count() as i32
    }
}