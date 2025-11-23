impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn largest_number(mut nums: Vec<i32>) -> i32 {
        let mut count = HashMap::new();
        for &num in &nums {
            *count.entry(num % 2).or_insert(0) += 1;
        }

        let mut result = 0;
        let mut digits = vec![];

        for num in &nums {
            let parity = num % 2;
            if count[&parity] > 0 {
                digits.push(*num);
                count.get_mut(&parity).map(|c| *c -= 1);
            }
        }

        digits.sort_by(|a, b| b.cmp(a));
        for digit in digits {
            result = result * 10 + digit;
        }

        result
    }
}
}