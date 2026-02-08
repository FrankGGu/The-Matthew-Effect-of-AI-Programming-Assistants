impl Solution {
    pub fn check_if_strings_can_be_made_equal(s1: String, s2: String) -> bool {
        let s1_chars: Vec<char> = s1.chars().collect();
        let s2_chars: Vec<char> = s2.chars().collect();

        let mut s1_even = vec![s1_chars[0], s1_chars[2]];
        let mut s2_even = vec![s2_chars[0], s2_chars[2]];
        s1_even.sort_unstable();
        s2_even.sort_unstable();

        let mut s1_odd = vec![s1_chars[1], s1_chars[3]];
        let mut s2_odd = vec![s2_chars[1], s2_chars[3]];
        s1_odd.sort_unstable();
        s2_odd.sort_unstable();

        s1_even == s2_even && s1_odd == s2_odd
    }
}