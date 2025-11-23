impl Solution {
    pub fn is_substring_present(s: String) -> bool {
        let rev_s: String = s.chars().rev().collect();
        for i in 0..s.len() - 1 {
            let substring = &s[i..i + 2];
            if rev_s.contains(substring) {
                return true;
            }
        }
        false
    }
}