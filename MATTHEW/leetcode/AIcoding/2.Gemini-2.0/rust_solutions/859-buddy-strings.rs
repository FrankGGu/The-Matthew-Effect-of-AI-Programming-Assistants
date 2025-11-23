impl Solution {
    pub fn buddy_strings(s: String, goal: String) -> bool {
        if s.len() != goal.len() {
            return false;
        }

        if s == goal {
            let mut seen = std::collections::HashSet::new();
            for c in s.chars() {
                if seen.contains(&c) {
                    return true;
                }
                seen.insert(c);
            }
            return false;
        }

        let mut diff_indices = Vec::new();
        for i in 0..s.len() {
            if s.chars().nth(i) != goal.chars().nth(i) {
                diff_indices.push(i);
            }
        }

        if diff_indices.len() != 2 {
            return false;
        }

        let i = diff_indices[0];
        let j = diff_indices[1];

        s.chars().nth(i) == goal.chars().nth(j) && s.chars().nth(j) == goal.chars().nth(i)
    }
}