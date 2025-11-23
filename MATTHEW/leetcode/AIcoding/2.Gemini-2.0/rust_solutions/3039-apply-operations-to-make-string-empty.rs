impl Solution {
    pub fn apply_operations(s: String) -> String {
        let mut s: Vec<char> = s.chars().collect();
        let n = s.len();
        let mut i = 0;
        while i < s.len() {
            if i + 1 < s.len() && s[i] == s[i + 1] {
                s[i] = (s[i] as u8 + 1) as char;
                s.remove(i + 1);
            } else {
                i += 1;
            }
        }

        s.into_iter().collect()
    }
}