impl Solution {
    pub fn is_substring_in_reverse(s: String, t: String) -> bool {
        let rev_s: String = s.chars().rev().collect();
        t.contains(&s) || t.contains(&rev_s)
    }
}