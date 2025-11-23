impl Solution {
    pub fn longest_valid_substring(word: String, forbidden: Vec<String>) -> i32 {
        let word_bytes = word.as_bytes();
        let mut max_len = 0;
        let forbidden_set: std::collections::HashSet<String> = forbidden.into_iter().collect();

        for i in 0..word_bytes.len() {
            let mut current_len = 0;
            for j in i..word_bytes.len() {
                let sub = String::from_utf8_lossy(&word_bytes[i..=j]).to_string();
                if forbidden_set.contains(&sub) {
                    break;
                }
                current_len = j - i + 1;
            }
            max_len = max_len.max(current_len as i32);
        }

        max_len
    }
}