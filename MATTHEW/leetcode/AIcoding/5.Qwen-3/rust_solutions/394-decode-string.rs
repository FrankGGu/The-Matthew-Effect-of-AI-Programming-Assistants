struct Solution;

impl Solution {
    pub fn decode_string(s: String) -> String {
        let mut stack = Vec::new();
        let mut current_num = 0;
        let mut current_str = String::new();

        for c in s.chars() {
            if c.is_digit(10) {
                current_num = current_num * 10 + c.to_digit(10).unwrap();
            } else if c == '[' {
                stack.push((current_str, current_num));
                current_str = String::new();
                current_num = 0;
            } else if c == ']' {
                let (prev_str, num) = stack.pop().unwrap();
                current_str = prev_str + &current_str.repeat(num as usize);
            } else {
                current_str.push(c);
            }
        }

        current_str
    }
}