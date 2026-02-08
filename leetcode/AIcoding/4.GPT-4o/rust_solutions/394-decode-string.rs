impl Solution {
    pub fn decode_string(s: String) -> String {
        let mut stack: Vec<(usize, String)> = Vec::new();
        let mut num = 0;
        let mut current_string = String::new();

        for c in s.chars() {
            if c.is_digit(10) {
                num = num * 10 + c.to_digit(10).unwrap() as usize;
            } else if c == '[' {
                stack.push((num, current_string));
                num = 0;
                current_string = String::new();
            } else if c == ']' {
                let (repeat_count, prev_string) = stack.pop().unwrap();
                current_string = prev_string + &current_string.repeat(repeat_count);
            } else {
                current_string.push(c);
            }
        }

        current_string
    }
}