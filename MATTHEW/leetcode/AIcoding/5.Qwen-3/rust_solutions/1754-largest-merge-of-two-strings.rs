impl Solution {
    pub fn largest_merge(s1: String, s2: String) -> String {
        let mut i = 0;
        let mut j = 0;
        let mut result = Vec::new();
        let s1_bytes = s1.as_bytes();
        let s2_bytes = s2.as_bytes();

        while i < s1.len() && j < s2.len() {
            if s1_bytes[i..] > s2_bytes[j..] {
                result.push(s1_bytes[i]);
                i += 1;
            } else {
                result.push(s2_bytes[j]);
                j += 1;
            }
        }

        while i < s1.len() {
            result.push(s1_bytes[i]);
            i += 1;
        }

        while j < s2.len() {
            result.push(s2_bytes[j]);
            j += 1;
        }

        String::from_utf8(result).unwrap()
    }
}