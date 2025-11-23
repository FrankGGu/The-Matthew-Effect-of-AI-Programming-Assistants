impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn largest_multiple_of_three(mut digits: Vec<i32>) -> String {
        let mut count = [0; 10];
        for &d in &digits {
            count[d as usize] += 1;
        }

        let sum: i32 = digits.iter().sum();

        if sum % 3 == 1 {
            if count[1] > 0 {
                count[1] -= 1;
            } else {
                count[2] -= 2;
            }
        } else if sum % 3 == 2 {
            if count[2] > 0 {
                count[2] -= 1;
            } else {
                count[1] -= 2;
            }
        }

        let mut result = Vec::new();
        for i in (0..10).rev() {
            for _ in 0..count[i] {
                result.push(i.to_string());
            }
        }

        if result.is_empty() {
            return String::new();
        }

        if result.len() == 1 && result[0] == "0" {
            return "0".to_string();
        }

        result.join("")
    }
}
}