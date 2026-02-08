impl Solution {
    pub fn are_almost_equal(s1: String, s2: String) -> bool {
        if s1 == s2 {
            return true;
        }
        let mut diff: Vec<usize> = Vec::new();
        for i in 0..s1.len() {
            if s1.as_bytes()[i] != s2.as_bytes()[i] {
                diff.push(i);
            }
        }
        if diff.len() == 2 {
            let i = diff[0];
            let j = diff[1];
            if s1.as_bytes()[i] == s2.as_bytes()[j] && s1.as_bytes()[j] == s2.as_bytes()[i] {
                return true;
            }
        }
        return false;
    }
}