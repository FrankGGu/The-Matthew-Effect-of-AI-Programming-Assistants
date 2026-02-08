impl Solution {
    pub fn last_substring(s: String) -> String {
        let bytes = s.as_bytes();
        let n = bytes.len();
        let mut max_char = 0;
        let mut last_pos = n;

        for i in (0..n).rev() {
            if bytes[i] > bytes[max_char] {
                max_char = i;
                last_pos = i + 1;
            } else if bytes[i] == bytes[max_char] {
                last_pos = i + 1;
            }
        }

        let mut result = String::new();
        for i in max_char..last_pos {
            result.push(bytes[i] as char);
        }

        result
    }
}