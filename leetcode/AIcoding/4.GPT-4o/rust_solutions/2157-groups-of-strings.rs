impl Solution {
    pub fn num_groups(strings: Vec<String>) -> i32 {
        use std::collections::HashSet;

        let mut visited = HashSet::new();
        let mut count = 0;

        for s in &strings {
            if !visited.contains(s) {
                count += 1;
                let pattern = Self::get_pattern(s);
                for t in &strings {
                    if Self::get_pattern(t) == pattern {
                        visited.insert(t.clone());
                    }
                }
            }
        }
        count
    }

    fn get_pattern(s: &str) -> String {
        let mut char_map = std::collections::HashMap::new();
        let mut pattern = String::new();
        let mut next_char = 'a';

        for c in s.chars() {
            let entry = char_map.entry(c).or_insert_with(|| {
                let temp = next_char;
                next_char = (next_char as u8 + 1) as char;
                temp
            });
            pattern.push(*entry);
        }
        pattern
    }
}