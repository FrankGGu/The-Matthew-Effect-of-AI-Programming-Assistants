impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn calculate(s: String) -> i32 {
        let mut stack = vec![];
        let mut num = 0;
        let mut sign = '+';

        for c in s.chars() {
            if c.is_digit(10) {
                num = num * 10 + c as i32 - '0' as i32;
            }
            if (!c.is_digit(10) && c != ' ') || c == '+' || c == '-' || c == '*' || c == '/' {
                match sign {
                    '+' => stack.push(num),
                    '-' => stack.push(-num),
                    '*' => stack.push(*stack.last().unwrap() * num),
                    '/' => stack.push(*stack.last().unwrap() / num),
                    _ => {}
                }
                sign = c;
                num = 0;
            }
        }

        match sign {
            '+' => stack.push(num),
            '-' => stack.push(-num),
            '*' => stack.push(*stack.last().unwrap() * num),
            '/' => stack.push(*stack.last().unwrap() / num),
            _ => {}
        }

        stack.iter().sum()
    }
}
}