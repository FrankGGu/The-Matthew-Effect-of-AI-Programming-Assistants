impl Solution {
    pub fn check_if_strings_can_be_made_equal(s1: String, s2: String) -> bool {
        let mut s1_even: Vec<char> = s1.chars().enumerate().filter(|(i, _)| i % 2 == 0).map(|(_, c)| c).collect();
        let mut s1_odd: Vec<char> = s1.chars().enumerate().filter(|(i, _)| i % 2 != 0).map(|(_, c)| c).collect();
        let mut s2_even: Vec<char> = s2.chars().enumerate().filter(|(i, _)| i % 2 == 0).map(|(_, c)| c).collect();
        let mut s2_odd: Vec<char> = s2.chars().enumerate().filter(|(i, _)| i % 2 != 0).map(|(_, c)| c).collect();

        s1_even.sort();
        s1_odd.sort();
        s2_even.sort();
        s2_odd.sort();

        s1_even == s2_even && s1_odd == s2_odd
    }
}