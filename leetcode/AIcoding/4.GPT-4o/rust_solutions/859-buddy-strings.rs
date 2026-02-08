impl Solution {
    pub fn buddy_strings(s: String, goal: String) -> bool {
        if s.len() != goal.len() {
            return false;
        }
        if s == goal {
            let mut seen = [0; 26];
            for c in s.chars() {
                seen[(c as u8 - b'a') as usize] += 1;
                if seen[(c as u8 - b'a') as usize] > 1 {
                    return true;
                }
            }
            return false;
        }
        let mut diff = vec![];
        for (a, b) in s.chars().zip(goal.chars()) {
            if a != b {
                diff.push((a, b));
            }
        }
        diff.len() == 2 && diff[0].0 == diff[1].1 && diff[0].1 == diff[1].0
    }
}