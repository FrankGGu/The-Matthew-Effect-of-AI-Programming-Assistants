impl Solution {
    pub fn are_almost_equal(s1: String, s2: String) -> bool {
        if s1 == s2 {
            return true;
        }
        let s1_bytes = s1.as_bytes();
        let s2_bytes = s2.as_bytes();
        let mut diff_indices = Vec::new();
        for i in 0..s1.len() {
            if s1_bytes[i] != s2_bytes[i] {
                diff_indices.push(i);
                if diff_indices.len() > 2 {
                    return false;
                }
            }
        }
        if diff_indices.len() != 2 {
            return false;
        }
        let i = diff_indices[0];
        let j = diff_indices[1];
        s1_bytes[i] == s2_bytes[j] && s1_bytes[j] == s2_bytes[i]
    }
}