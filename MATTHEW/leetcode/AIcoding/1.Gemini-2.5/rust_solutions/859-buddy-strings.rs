use std::collections::HashSet;

impl Solution {
    pub fn buddy_strings(s: String, goal: String) -> bool {
        if s.len() != goal.len() {
            return false;
        }

        if s == goal {
            let mut seen_chars = HashSet::new();
            for c in s.chars() {
                if seen_chars.contains(&c) {
                    return true;
                }
                seen_chars.insert(c);
            }
            return false;
        }

        let s_chars: Vec<char> = s.chars().collect();
        let goal_chars: Vec<char> = goal.chars().collect();
        let mut diff_indices = Vec::new();

        for i in 0..s.len() {
            if s_chars[i] != goal_chars[i] {
                diff_indices.push(i);
            }
        }

        if diff_indices.len() == 2 {
            let i1 = diff_indices[0];
            let i2 = diff_indices[1];
            return s_chars[i1] == goal_chars[i2] && s_chars[i2] == goal_chars[i1];
        }

        false
    }
}