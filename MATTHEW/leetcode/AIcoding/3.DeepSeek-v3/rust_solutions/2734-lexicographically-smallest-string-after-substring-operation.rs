impl Solution {
    pub fn smallest_string(s: String) -> String {
        let mut s_bytes = s.into_bytes();
        let mut i = 0;
        while i < s_bytes.len() && s_bytes[i] == b'a' {
            i += 1;
        }
        if i == s_bytes.len() {
            s_bytes[s_bytes.len() - 1] = b'z';
            return String::from_utf8(s_bytes).unwrap();
        }
        let mut j = i;
        while j < s_bytes.len() && s_bytes[j] != b'a' {
            s_bytes[j] -= 1;
            j += 1;
        }
        String::from_utf8(s_bytes).unwrap()
    }
}