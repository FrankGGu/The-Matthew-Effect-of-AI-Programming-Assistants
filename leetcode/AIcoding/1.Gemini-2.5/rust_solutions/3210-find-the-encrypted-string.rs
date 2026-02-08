impl Solution {
    pub fn get_encrypted_string(s: String, k: i32) -> String {
        let n = s.len();
        let k_usize = k as usize;
        let s_chars: Vec<char> = s.chars().collect();
        let mut result_chars: Vec<char> = Vec::with_capacity(n);

        for i in 0..n {
            let new_idx = (i + k_usize) % n;
            result_chars.push(s_chars[new_idx]);
        }

        result_chars.into_iter().collect()
    }
}