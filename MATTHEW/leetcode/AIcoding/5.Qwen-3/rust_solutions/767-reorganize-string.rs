impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn reorganize_string(s: String) -> String {
        let mut count = HashMap::new();
        let mut max_freq = 0;
        let mut max_char = ' ';

        for c in s.chars() {
            *count.entry(c).or_insert(0) += 1;
            if *count.get(&c).unwrap() > max_freq {
                max_freq = *count.get(&c).unwrap();
                max_char = c;
            }
        }

        if max_freq > (s.len() + 1) / 2 {
            return String::new();
        }

        let mut result = vec![' '; s.len()];
        let mut index = 0;

        for _ in 0..max_freq {
            result[index] = max_char;
            index += 2;
        }

        for (c, &freq) in &count {
            if *c == max_char {
                continue;
            }
            for _ in 0..freq {
                if index >= s.len() {
                    index = 1;
                }
                result[index] = *c;
                index += 2;
            }
        }

        result.into_iter().collect()
    }
}
}