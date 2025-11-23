impl Solution {
    pub fn dynamic_password(password: String, index: i32) -> String {
        let n = password.len();
        let index = (index % n as i32 + n as i32) as usize % n;
        let (left, right) = password.split_at(index);
        right.to_string() + left
    }
}