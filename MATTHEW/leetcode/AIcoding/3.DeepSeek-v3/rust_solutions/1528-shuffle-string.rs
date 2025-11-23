impl Solution {
    pub fn restore_string(s: String, indices: Vec<i32>) -> String {
        let mut result = vec![' '; s.len()];
        for (i, c) in s.chars().enumerate() {
            result[indices[i] as usize] = c;
        }
        result.into_iter().collect()
    }
}