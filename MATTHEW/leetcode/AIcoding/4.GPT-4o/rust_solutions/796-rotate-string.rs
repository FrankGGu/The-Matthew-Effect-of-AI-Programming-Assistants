impl Solution {
    pub fn rotate_string(s: String, goal: String) -> bool {
        if s.len() != goal.len() {
            return false;
        }
        let double_s = format!("{}{}", s, s);
        double_s.contains(&goal)
    }
}