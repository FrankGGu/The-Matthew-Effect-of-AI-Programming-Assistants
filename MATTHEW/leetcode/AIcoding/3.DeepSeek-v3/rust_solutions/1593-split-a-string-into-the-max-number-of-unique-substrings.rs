impl Solution {
    pub fn max_unique_split(s: String) -> i32 {
        let mut max = 0;
        let mut visited = std::collections::HashSet::new();
        Self::backtrack(&s, 0, &mut visited, &mut max);
        max
    }

    fn backtrack(s: &str, start: usize, visited: &mut std::collections::HashSet<String>, max: &mut i32) {
        if start == s.len() {
            *max = (*max).max(visited.len() as i32);
            return;
        }

        for end in start + 1..=s.len() {
            let substring = s[start..end].to_string();
            if !visited.contains(&substring) {
                visited.insert(substring.clone());
                Self::backtrack(s, end, visited, max);
                visited.remove(&substring);
            }
        }
    }
}