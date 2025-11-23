impl Solution {
    pub fn calculate(s: String) -> i32 {
        let mut stack: Vec<i32> = Vec::new();
        let mut num = 0;
        let mut op = '+';

        for (i, c) in s.chars().enumerate() {
            if c.is_digit(10) {
                num = num * 10 + c.to_digit(10).unwrap() as i32;
            }
            if (!c.is_digit(10) && c != ' ') || i == s.len() - 1 {
                match op {
                    '+' => stack.push(num),
                    '-' => stack.push(-num),
                    '*' => {
                        let prev = stack.pop().unwrap();
                        stack.push(prev * num);
                    }
                    '/' => {
                        let prev = stack.pop().unwrap();
                        stack.push(prev / num);
                    }
                    _ => {}
                }
                op = c;
                num = 0;
            }
        }

        stack.iter().sum()
    }
}