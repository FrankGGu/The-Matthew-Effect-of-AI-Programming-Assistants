impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn find_original_string(encoded: String) -> String {
        let mut freq = HashMap::new();
        for c in encoded.chars() {
            *freq.entry(c).or_insert(0) += 1;
        }

        let mut result = Vec::new();
        let mut seen = HashMap::new();

        for c in encoded.chars() {
            if !seen.contains_key(&c) {
                let count = *freq.get(&c).unwrap();
                let mut temp = vec![];
                let mut i = 0;
                while i < encoded.len() {
                    let ch = encoded.chars().nth(i).unwrap();
                    if ch == c {
                        temp.push(ch);
                        i += 1;
                    } else {
                        i += 1;
                    }
                }
                let len = temp.len();
                if len % 2 == 0 {
                    for _ in 0..len / 2 {
                        result.push(c);
                    }
                } else {
                    for _ in 0..(len + 1) / 2 {
                        result.push(c);
                    }
                }
                seen.insert(c, true);
            }
        }

        result.into_iter().collect()
    }
}
}