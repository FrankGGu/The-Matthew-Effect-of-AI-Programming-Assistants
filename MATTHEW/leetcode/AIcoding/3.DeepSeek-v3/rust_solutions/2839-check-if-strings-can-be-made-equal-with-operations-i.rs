impl Solution {
    pub fn can_be_equal(s1: String, s2: String) -> bool {
        let mut s1_chars: Vec<char> = s1.chars().collect();
        let mut s2_chars: Vec<char> = s2.chars().collect();

        if s1_chars.len() != s2_chars.len() {
            return false;
        }

        for i in 0..s1_chars.len() {
            if s1_chars[i] != s2_chars[i] {
                if i + 2 < s1_chars.len() {
                    s1_chars.swap(i, i + 2);
                } else {
                    return false;
                }
            }
        }

        s1_chars == s2_chars
    }
}