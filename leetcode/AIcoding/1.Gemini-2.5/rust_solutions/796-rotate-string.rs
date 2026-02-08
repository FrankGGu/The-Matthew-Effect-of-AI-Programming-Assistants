impl Solution {
    pub fn rotate_string(s: String, goal: String) -> bool {
        if s.len() != goal.len() {
            return false;
        }
        if s.is_empty() {
            return true;
        }

        let s_s = s.clone() + &s;
        s_s.contains(&goal)
    }
}