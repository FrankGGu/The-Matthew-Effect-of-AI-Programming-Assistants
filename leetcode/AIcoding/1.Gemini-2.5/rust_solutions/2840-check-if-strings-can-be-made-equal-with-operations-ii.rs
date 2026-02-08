impl Solution {
    pub fn check_strings(s1: String, s2: String) -> bool {
        let n = s1.len();
        let s1_chars: Vec<char> = s1.chars().collect();
        let s2_chars: Vec<char> = s2.chars().collect();

        let mut s1_even_chars: Vec<char> = Vec::new();
        let mut s1_odd_chars: Vec<char> = Vec::new();
        let mut s2_even_chars: Vec<char> = Vec::new();
        let mut s2_odd_chars: Vec<char> = Vec::new();

        for i in 0..n {
            if i % 2 == 0 {
                s1_even_chars.push(s1_chars[i]);
                s2_even_chars.push(s2_chars[i]);
            } else {
                s1_odd_chars.push(s1_chars[i]);
                s2_odd_chars.push(s2_chars[i]);
            }
        }

        s1_even_chars.sort_unstable();
        s1_odd_chars.sort_unstable();
        s2_even_chars.sort_unstable();
        s2_odd_chars.sort_unstable();

        s1_even_chars == s2_even_chars && s1_odd_chars == s2_odd_chars
    }
}