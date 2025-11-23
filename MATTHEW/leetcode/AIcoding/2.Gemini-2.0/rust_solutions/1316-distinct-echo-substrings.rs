impl Solution {
    pub fn distinct_echo_substrings(text: String) -> i32 {
        let n = text.len();
        let text_bytes = text.as_bytes();
        let mut distinct_substrings = std::collections::HashSet::new();

        for len in 1..=n / 2 {
            for i in 0..=n - 2 * len {
                if text_bytes[i..i + len] == text_bytes[i + len..i + 2 * len] {
                    distinct_substrings.insert(String::from_utf8_lossy(&text_bytes[i..i + len]).to_string());
                }
            }
        }

        distinct_substrings.len() as i32
    }
}