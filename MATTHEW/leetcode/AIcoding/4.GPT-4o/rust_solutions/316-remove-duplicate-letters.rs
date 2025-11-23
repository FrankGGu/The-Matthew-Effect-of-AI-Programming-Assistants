impl Solution {
    pub fn remove_duplicate_letters(s: String) -> String {
        use std::collections::HashMap;
        use std::collections::HashSet;

        let mut last_occurrence = HashMap::new();
        let mut seen = HashSet::new();
        let mut stack = Vec::new();

        for (i, c) in s.chars().enumerate() {
            last_occurrence.insert(c, i);
        }

        for (i, c) in s.chars().enumerate() {
            if seen.contains(&c) {
                continue;
            }
            while let Some(&top) = stack.last() {
                if top > c && last_occurrence[&top] > i {
                    seen.remove(&top);
                    stack.pop();
                } else {
                    break;
                }
            }
            seen.insert(c);
            stack.push(c);
        }

        stack.iter().collect()
    }
}