struct Solution;

impl Solution {
    pub fn calculate(s: String) -> i32 {
        let mut stack = Vec::new();
        let mut num = 0;
        let mut sign = '+';
        let mut i = 0;
        while i < s.len() {
            let c = s.chars().nth(i).unwrap();
            if c.is_digit(10) {
                num = num * 10 + (c as i32 - '0' as i32);
            } else if c == '(' {
                stack.push(sign);
                stack.push(num);
                num = 0;
                sign = '+';
            } else if c == ')' {
                let res = match sign {
                    '+' => num,
                    '-' => -num,
                    _ => unreachable!(),
                };
                num = 0;
                while let Some(top) = stack.pop() {
                    if top == '+' || top == '-' {
                        let op = top;
                        let prev = stack.pop().unwrap();
                        num = match op {
                            '+' => prev + num,
                            '-' => prev - num,
                            _ => unreachable!(),
                        };
                        break;
                    }
                }
            } else if c != ' ' {
                let res = match sign {
                    '+' => num,
                    '-' => -num,
                    _ => unreachable!(),
                };
                num = 0;
                sign = c;
                if c == '+' || c == '-' {
                    stack.push(sign);
                } else {
                    stack.push(res);
                }
            }
            i += 1;
        }
        let res = match sign {
            '+' => num,
            '-' => -num,
            _ => unreachable!(),
        };
        res
    }
}