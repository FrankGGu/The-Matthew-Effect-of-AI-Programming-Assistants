struct Solution;

impl Solution {
    pub fn password_collision(password: String, target: i32) -> String {
        let mut result = String::new();
        let mut current = 0;
        for c in password.chars() {
            if c.is_ascii_digit() {
                current = current * 10 + (c as i32 - '0' as i32);
            } else {
                result.push(c);
                current = 0;
            }
            if current == target {
                return result.clone();
            }
        }
        result
    }
}