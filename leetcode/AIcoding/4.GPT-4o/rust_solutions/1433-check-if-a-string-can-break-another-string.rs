impl Solution {
    pub fn check_if_can_break(s1: String, s2: String) -> bool {
        let mut s1: Vec<_> = s1.chars().collect();
        let mut s2: Vec<_> = s2.chars().collect();
        s1.sort();
        s2.sort();

        let can_break = |s1: &[char], s2: &[char]| {
            s1.iter().zip(s2.iter()).all(|(c1, c2)| c1 >= c2)
        };

        can_break(&s1, &s2) || can_break(&s2, &s1)
    }
}