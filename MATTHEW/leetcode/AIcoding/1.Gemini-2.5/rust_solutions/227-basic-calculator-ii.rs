impl Solution {
    pub fn calculate(s: String) -> i32 {
        if s.is_empty() {
            return 0;
        }

        let mut stack: Vec<i32> = Vec::new();
        let mut current_number: i32 = 0;
        let mut operation: char = '+';

        let chars: Vec<char> = s.chars().collect();
        let n = chars.len();

        for i in 0..n {
            let c = chars[i];

            if c.is_digit(10) {
                current_number = current_number * 10 + (c as i32 - '0' as i32);
            }

            if (!c.is_digit(10) && c != ' ') || i == n - 1 {
                match operation {
                    '+' => stack.push(current_number),
                    '-' => stack.push(-current_number),
                    '*' => {
                        let last = stack.pop().unwrap();
                        stack.push(last * current_number);
                    }
                    '/' => {
                        let last = stack.pop().unwrap();
                        stack.push(last / current_number);
                    }
                    _ => {}
                }
                operation = c;
                current_number = 0;
            }
        }

        stack.iter().sum()
    }
}