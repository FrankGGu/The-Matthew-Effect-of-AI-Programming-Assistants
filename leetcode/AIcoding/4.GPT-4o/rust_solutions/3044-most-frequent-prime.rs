impl Solution {
    pub fn most_frequent_prime(nums: Vec<i32>) -> i32 {
        use std::collections::HashMap;

        fn is_prime(num: i32) -> bool {
            if num < 2 {
                return false;
            }
            for i in 2..=((num as f64).sqrt() as i32) {
                if num % i == 0 {
                    return false;
                }
            }
            true
        }

        let mut prime_count = HashMap::new();

        for &num in &nums {
            if is_prime(num) {
                *prime_count.entry(num).or_insert(0) += 1;
            }
        }

        prime_count.into_iter()
            .max_by_key(|&(_, count)| count)
            .map(|(prime, _)| prime)
            .unwrap_or(-1)
    }
}