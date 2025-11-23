impl Solution {
    pub fn partition_string(s: String) -> i32 {
        let mut count = 0;
        let mut seen = std::collections::HashSet::new();
        for c in s.chars() {
            if seen.contains(&c) {
                count += 1;
                seen.clear();
            }
            seen.insert(c);
        }
        if !seen.is_empty() {
            count += 1;
        }
        count
    }
}