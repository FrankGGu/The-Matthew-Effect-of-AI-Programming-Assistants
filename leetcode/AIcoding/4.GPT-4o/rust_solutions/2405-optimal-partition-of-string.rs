impl Solution {
    pub fn partition_string(s: String) -> i32 {
        let mut seen = std::collections::HashSet::new();
        let mut count = 1;

        for c in s.chars() {
            if seen.contains(&c) {
                count += 1;
                seen.clear();
            }
            seen.insert(c);
        }

        count
    }
}