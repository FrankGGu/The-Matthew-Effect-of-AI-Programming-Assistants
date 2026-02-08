use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn remove_duplicate_letters(s: String) -> String {
        let mut last_occurrence = HashMap::new();
        for (i, ch) in s.chars().enumerate() {
            last_occurrence.insert(ch, i);
        }

        let mut stack = Vec::new();
        let mut seen = HashSet::new();

        for (i, ch) in s.chars().enumerate() {
            if !seen.contains(&ch) {
                while let Some(&top) = stack.last() {
                    if ch < top && i < *last_occurrence.get(&top).unwrap() {
                        seen.remove(&stack.pop().unwrap());
                    } else {
                        break;
                    }
                }
                seen.insert(ch);
                stack.push(ch);
            }
        }

        stack.into_iter().collect()
    }
}