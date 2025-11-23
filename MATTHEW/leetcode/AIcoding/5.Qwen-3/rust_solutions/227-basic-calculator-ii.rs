struct Solution;

impl Solution {
    pub fn calculate(s: String) -> i32 {
        let mut stack = Vec::new();
        let mut num = 0;
        let mut sign = '+';
        for (i, c) in s.chars().enumerate() {
            if c.is_digit(10) {
                num = num * 10 + c as i32 - '0' as i32;
            }
            if (!c.is_digit(10) && c != ' ') || i == s.len() - 1 {
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
        stack.iter().sum()
    }
}