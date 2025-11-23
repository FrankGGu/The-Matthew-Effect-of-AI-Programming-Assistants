impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn find_even_numbers(digits: Vec<i32>) -> Vec<i32> {
        let mut result = HashSet::new();
        let len = digits.len();

        for i in 0..len {
            if digits[i] == 0 {
                continue;
            }
            for j in 0..len {
                if j == i {
                    continue;
                }
                for k in 0..len {
                    if k == i || k == j {
                        continue;
                    }
                    let num = digits[i] * 100 + digits[j] * 10 + digits[k];
                    if num % 2 == 0 {
                        result.insert(num);
                    }
                }
            }
        }

        let mut result: Vec<i32> = result.into_iter().collect();
        result.sort();
        result
    }
}
}