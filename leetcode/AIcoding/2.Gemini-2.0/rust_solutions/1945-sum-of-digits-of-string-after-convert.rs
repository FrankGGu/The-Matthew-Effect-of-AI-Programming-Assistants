impl Solution {
    pub fn get_lucky(s: String, k: i32) -> i32 {
        let mut num_str = String::new();
        for c in s.chars() {
            num_str.push_str(&(c as u32 - 'a' as u32 + 1).to_string());
        }

        let mut result = 0;
        for _ in 0..k {
            result = 0;
            for c in num_str.chars() {
                result += c.to_digit(10).unwrap() as i32;
            }
            num_str = result.to_string();
        }

        result
    }
}