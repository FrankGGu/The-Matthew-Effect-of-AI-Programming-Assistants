impl Solution {
    pub fn restore_string(s: String, indices: Vec<i32>) -> String {
        let n = s.len();
        let mut result_chars: Vec<char> = vec![' '; n];
        let s_chars: Vec<char> = s.chars().collect();

        for i in 0..n {
            let target_index = indices[i] as usize;
            result_chars[target_index] = s_chars[i];
        }

        result_chars.into_iter().collect()
    }
}