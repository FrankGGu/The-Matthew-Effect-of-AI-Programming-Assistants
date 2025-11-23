impl Solution {
    pub fn calculate(s: String) -> i32 {
        let mut stack = Vec::new();
        let mut num = 0;
        let mut sign = '+';
        let chars: Vec<char> = s.chars().collect();

        for i in 0..chars.len() {
            let c = chars[i];
            if c.is_digit(10) {
                num = num * 10 + c.to_digit(10).unwrap() as i32;
            }
            if (!c.is_digit(10) && c != ' ') || i == chars.len() - 1 {
                match sign {
                    '+' => stack.push(num),
                    '-' => stack.push(-num),
                    '*' => {
                        let top = stack.pop().unwrap();
                        stack.push(top * num);
                    },
                    '/' => {
                        let top = stack.pop().unwrap();
                        stack.push(top / num);
                    },
                    _ => (),
                }
                sign = c;
                num = 0;
            }
        }
        stack.iter().sum()
    }
}