impl Solution {
    pub fn buddy_strings(s: String, goal: String) -> bool {
        if s.len() != goal.len() {
            return false;
        }
        let s_bytes = s.as_bytes();
        let goal_bytes = goal.as_bytes();
        let mut diff_indices = Vec::new();
        let mut char_counts = [0; 26];

        for i in 0..s_bytes.len() {
            if s_bytes[i] != goal_bytes[i] {
                diff_indices.push(i);
                if diff_indices.len() > 2 {
                    return false;
                }
            }
            char_counts[(s_bytes[i] - b'a') as usize] += 1;
        }

        if diff_indices.len() == 2 {
            let i = diff_indices[0];
            let j = diff_indices[1];
            return s_bytes[i] == goal_bytes[j] && s_bytes[j] == goal_bytes[i];
        } else if diff_indices.is_empty() {
            return char_counts.iter().any(|&count| count >= 2);
        } else {
            return false;
        }
    }
}