impl Solution {
    pub fn calculate(s: String) -> i32 {
        let mut stack = Vec::new();
        let mut num = 0;
        let mut sign = 1; // 1 for positive, -1 for negative
        let mut i = 0;
        let bytes = s.as_bytes();

        while i < bytes.len() {
            if bytes[i].is_ascii_digit() {
                num = num * 10 + (bytes[i] - b'0') as i32;
            } else if bytes[i] == b'+' {
                stack.push(sign * num);
                num = 0;
                sign = 1;
            } else if bytes[i] == b'-' {
                stack.push(sign * num);
                num = 0;
                sign = -1;
            } else if bytes[i] == b'(' {
                stack.push(sign);
                stack.push(0);
                sign = 1;
            } else if bytes[i] == b')' {
                stack.push(sign * num);
                num = 0;
                let mut sum = 0;
                while let Some(top) = stack.pop() {
                    if top == 1 || top == -1 {
                        sign = top;
                        break;
                    }
                    sum += top;
                }
                stack.push(sum);
            }
            i += 1;
        }
        stack.push(sign * num);
        stack.iter().sum()
    }
}