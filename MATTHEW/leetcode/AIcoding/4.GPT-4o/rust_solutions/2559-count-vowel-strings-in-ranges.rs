impl Solution {
    pub fn vowel_strings(words: Vec<String>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let is_vowel_string = |s: &str| {
            let bytes = s.as_bytes();
            (b'a' == bytes[0] || b'e' == bytes[0] || b'i' == bytes[0] || b'o' == bytes[0] || b'u' == bytes[0]) &&
            (b'a' == bytes[bytes.len() - 1] || b'e' == bytes[bytes.len() - 1] || b'i' == bytes[bytes.len() - 1] || b'o' == bytes[bytes.len() - 1] || b'u' == bytes[bytes.len() - 1])
        };

        let mut prefix_sum = vec![0; words.len() + 1];
        for i in 0..words.len() {
            prefix_sum[i + 1] = prefix_sum[i] + if is_vowel_string(&words[i]) { 1 } else { 0 };
        }

        queries.into_iter().map(|q| prefix_sum[q[1] as usize + 1] - prefix_sum[q[0] as usize]).collect()
    }
}