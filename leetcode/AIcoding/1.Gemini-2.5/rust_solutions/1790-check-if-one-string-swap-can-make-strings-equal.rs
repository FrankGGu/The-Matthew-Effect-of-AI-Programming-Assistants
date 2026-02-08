impl Solution {
    pub fn are_almost_equal(s1: String, s2: String) -> bool {
        if s1 == s2 {
            return true;
        }

        let s1_chars: Vec<char> = s1.chars().collect();
        let s2_chars: Vec<char> = s2.chars().collect();

        let mut diff_indices = Vec::new();
        for i in 0..s1_chars.len() {
            if s1_chars[i] != s2_chars[i] {
                diff_indices.push(i);
            }
        }

        if diff_indices.len() == 2 {
            let i1 = diff_indices[0];
            let i2 = diff_indices[1];
            if s1_chars[i1] == s2_chars[i2] && s1_chars[i2] == s2_chars[i1] {
                return true;
            }
        }

        false
    }
}