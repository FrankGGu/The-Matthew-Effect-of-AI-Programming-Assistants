impl Solution {
    pub fn check_if_can_break(s1: String, s2: String) -> bool {
        let mut chars1: Vec<char> = s1.chars().collect();
        let mut chars2: Vec<char> = s2.chars().collect();

        chars1.sort_unstable();
        chars2.sort_unstable();

        let can_break_one_way = |c1: &[char], c2: &[char]| -> bool {
            for i in 0..c1.len() {
                if c1[i] < c2[i] {
                    return false;
                }
            }
            true
        };

        can_break_one_way(&chars1, &chars2) || can_break_one_way(&chars2, &chars1)
    }
}