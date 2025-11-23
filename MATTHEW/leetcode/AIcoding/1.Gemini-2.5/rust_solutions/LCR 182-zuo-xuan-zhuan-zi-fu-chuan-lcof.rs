struct Solution;

impl Solution {
    pub fn dynamic_password(s: String, k: i32) -> String {
        let n = s.len();
        if n == 0 {
            return String::new();
        }

        let k_actual = (k as usize) % n;

        let (left, right) = s.split_at(k_actual);
        format!("{}{}", right, left)
    }
}