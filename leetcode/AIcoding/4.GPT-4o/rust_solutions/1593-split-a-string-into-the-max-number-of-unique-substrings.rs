impl Solution {
    pub fn max_unique_split(s: String) -> i32 {
        let mut result = 0;
        let mut seen = std::collections::HashSet::new();
        let mut current = String::new();
        Self::backtrack(&s, 0, &mut seen, &mut current, &mut result);
        result
    }

    fn backtrack(s: &str, start: usize, seen: &mut std::collections::HashSet<String>, current: &mut String, result: &mut i32) {
        if start == s.len() {
            *result = (*result).max(seen.len() as i32);
            return;
        }
        for end in start + 1..=s.len() {
            let substring = &s[start..end];
            if !seen.contains(substring) {
                seen.insert(substring.to_string());
                Self::backtrack(s, end, seen, current, result);
                seen.remove(substring);
            }
        }
    }
}