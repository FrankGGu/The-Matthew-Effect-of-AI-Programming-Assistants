impl Solution {

use std::vec;

impl Solution {
    pub fn separate_digits(mut nums: Vec<i32>) -> Vec<i32> {
        let mut result = Vec::new();
        for num in nums.iter_mut() {
            let mut n = *num;
            let mut digits = Vec::new();
            while n > 0 {
                digits.push(n % 10);
                n /= 10;
            }
            digits.reverse();
            result.extend(digits);
        }
        result
    }
}
}