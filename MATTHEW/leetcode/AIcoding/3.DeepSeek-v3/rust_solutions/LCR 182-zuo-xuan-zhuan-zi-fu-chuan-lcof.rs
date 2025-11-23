impl Solution {
    pub fn dynamic_password(password: String, target: i32) -> String {
        let target = target as usize;
        let len = password.len();
        let mut result = String::with_capacity(len);
        result.push_str(&password[target..]);
        result.push_str(&password[..target]);
        result
    }
}