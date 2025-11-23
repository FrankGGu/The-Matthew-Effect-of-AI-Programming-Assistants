impl Solution {
    pub fn decode_string(s: String) -> String {
        let mut stack: Vec<(usize, String)> = Vec::new();
        let mut current_str = String::new();
        let mut current_num = 0;

        for c in s.chars() {
            match c {
                '[' => {
                    stack.push((current_num, current_str));
                    current_str = String::new();
                    current_num = 0;
                },
                ']' => {
                    let (num, prev_str) = stack.pop().unwrap();
                    current_str = prev_str + &current_str.repeat(num);
                },
                '0'..='9' => {
                    current_num = current_num * 10 + (c as usize - '0' as usize);
                },
                _ => {
                    current_str.push(c);
                },
            }
        }

        current_str
    }
}