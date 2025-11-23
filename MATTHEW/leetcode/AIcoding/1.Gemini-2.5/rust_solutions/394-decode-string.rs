impl Solution {
    pub fn decode_string(s: String) -> String {
        let mut num_stack: Vec<i32> = Vec::new();
        let mut str_stack: Vec<String> = Vec::new();
        let mut current_num: i32 = 0;
        let mut current_str: String = String::new();

        for c in s.chars() {
            if c.is_digit(10) {
                current_num = current_num * 10 + (c as i32 - '0' as i32);
            } else if c == '[' {
                str_stack.push(current_str);
                num_stack.push(current_num);
                current_str = String::new();
                current_num = 0;
            } else if c == ']' {
                let num = num_stack.pop().unwrap();
                let prev_str = str_stack.pop().unwrap();
                let repeated_str: String = current_str.repeat(num as usize);
                current_str = prev_str + &repeated_str;
            } else {
                current_str.push(c);
            }
        }

        current_str
    }
}