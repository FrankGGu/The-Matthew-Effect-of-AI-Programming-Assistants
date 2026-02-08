impl Solution {
    pub fn check_if_can_break(s1: String, s2: String) -> bool {
        let mut s1_chars: Vec<char> = s1.chars().collect();
        let mut s2_chars: Vec<char> = s2.chars().collect();

        s1_chars.sort();
        s2_chars.sort();

        let mut s1_breaks_s2 = true;
        let mut s2_breaks_s1 = true;

        for (c1, c2) in s1_chars.iter().zip(s2_chars.iter()) {
            if c1 < c2 {
                s1_breaks_s2 = false;
            }
            if c2 < c1 {
                s2_breaks_s1 = false;
            }
            if !s1_breaks_s2 && !s2_breaks_s1 {
                return false;
            }
        }

        s1_breaks_s2 || s2_breaks_s1
    }
}