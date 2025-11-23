impl Solution {
    pub fn check_if_can_break(s1: String, s2: String) -> bool {
        let mut v1: Vec<char> = s1.chars().collect();
        let mut v2: Vec<char> = s2.chars().collect();
        v1.sort();
        v2.sort();

        let mut break1 = true;
        let mut break2 = true;

        for i in 0..v1.len() {
            if v1[i] < v2[i] {
                break1 = false;
            }
            if v2[i] < v1[i] {
                break2 = false;
            }
        }

        break1 || break2
    }
}