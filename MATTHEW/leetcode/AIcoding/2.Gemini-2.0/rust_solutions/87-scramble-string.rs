impl Solution {
    pub fn is_scramble(s1: String, s2: String) -> bool {
        if s1.len() != s2.len() {
            return false;
        }
        if s1 == s2 {
            return true;
        }
        if s1.len() == 1 {
            return false;
        }

        let mut chars1: Vec<char> = s1.chars().collect();
        chars1.sort();
        let mut chars2: Vec<char> = s2.chars().collect();
        chars2.sort();

        if chars1 != chars2 {
            return false;
        }

        for i in 1..s1.len() {
            let s1_left = &s1[..i];
            let s1_right = &s1[i..];
            let s2_left = &s2[..i];
            let s2_right = &s2[i..];

            if Solution::is_scramble(s1_left.to_string(), s2_left.to_string()) &&
                Solution::is_scramble(s1_right.to_string(), s2_right.to_string()) {
                return true;
            }

            let s2_left_rev = &s2[s2.len() - i..];
            let s2_right_rev = &s2[..s2.len() - i];

            if Solution::is_scramble(s1_left.to_string(), s2_left_rev.to_string()) &&
                Solution::is_scramble(s1_right.to_string(), s2_right_rev.to_string()) {
                return true;
            }
        }

        false
    }
}