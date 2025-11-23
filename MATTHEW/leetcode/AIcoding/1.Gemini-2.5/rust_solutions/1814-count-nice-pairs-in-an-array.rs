use std::collections::HashMap;

impl Solution {
    pub fn count_nice_pairs(nums: Vec<i32>) -> i32 {
        let modulo = 1_000_000_007;
        let mut counts: HashMap<i32, i64> = HashMap::new();

        for &num in nums.iter() {
            let diff = num - Self::rev(num);
            *counts.entry(diff).or_insert(0) += 1;
        }

        let mut total_pairs: i64 = 0;
        for &count in counts.values() {
            let num_pairs_for_diff = (count * (count - 1) / 2) % modulo;
            total_pairs = (total_pairs + num_pairs_for_diff) % modulo;
        }

        total_pairs as i32
    }

    fn rev(mut n: i32) -> i32 {
        let mut reversed_n = 0;
        while n > 0 {
            let digit = n % 10;
            reversed_n = reversed_n * 10 + digit;
            n /= 10;
        }
        reversed_n
    }
}