impl Solution {
    pub fn check_if_can_break(s1: String, s2: String) -> bool {
        let mut s1: Vec<char> = s1.chars().collect();
        let mut s2: Vec<char> = s2.chars().collect();
        s1.sort();
        s2.sort();
        s1.iter().zip(s2.iter()).all(|(&a, &b)| a <= b) || s1.iter().zip(s2.iter()).all(|(&a, &b)| a >= b)
    }
}