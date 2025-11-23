impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn minimum_sum(num: i32) -> i32 {
        let mut digits = Vec::new();
        let mut n = num;
        for _ in 0..4 {
            digits.push(n % 10);
            n /= 10;
        }
        digits.sort();
        let a = digits[0] * 10 + digits[2];
        let b = digits[1] * 10 + digits[3];
        a + b
    }
}
}