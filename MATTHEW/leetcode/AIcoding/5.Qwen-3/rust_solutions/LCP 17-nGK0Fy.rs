struct Solution;

impl Solution {
    pub fn calculate(s: String) -> i32 {
        let mut stack = Vec::new();
        let mut num = 0;
        let mut sign = '+';

        for c in s.chars() {
            if c.is_digit(10) {
                num = num * 10 + (c as i32 - '0' as i32);
            }
            if !c.is_digit(10) && c != ' ' || c == ' ' && !s.ends_with(c) {
                match sign {
                    '+' => stack.push(num),
                    '-' => stack.push(-num),
                    '*' => stack.push(*stack.pop().unwrap() * num),
                    '/' => stack.push(*stack.pop().unwrap() / num),
                    _ => {}
                }
                sign = c;
                num = 0;
            }
        }

        match sign {
            '+' => stack.push(num),
            '-' => stack.push(-num),
            '*' => stack.push(*stack.pop().unwrap() * num),
            '/' => stack.push(*stack.pop().unwrap() / num),
            _ => {}
        }

        stack.iter().sum()
    }
}