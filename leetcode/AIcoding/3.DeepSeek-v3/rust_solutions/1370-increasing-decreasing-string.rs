use std::collections::BTreeMap;

impl Solution {
    pub fn sort_string(s: String) -> String {
        let mut freq = BTreeMap::new();
        for c in s.chars() {
            *freq.entry(c).or_insert(0) += 1;
        }

        let mut result = String::new();
        while !freq.is_empty() {
            // Step 1-3: Smallest to largest
            let keys: Vec<char> = freq.keys().cloned().collect();
            for &c in &keys {
                if let Some(count) = freq.get_mut(&c) {
                    result.push(c);
                    *count -= 1;
                    if *count == 0 {
                        freq.remove(&c);
                    }
                }
            }

            // Step 4-6: Largest to smallest
            let keys: Vec<char> = freq.keys().rev().cloned().collect();
            for &c in &keys {
                if let Some(count) = freq.get_mut(&c) {
                    result.push(c);
                    *count -= 1;
                    if *count == 0 {
                        freq.remove(&c);
                    }
                }
            }
        }
        result
    }
}