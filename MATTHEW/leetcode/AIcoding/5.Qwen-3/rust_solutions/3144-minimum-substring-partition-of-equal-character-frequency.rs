impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn partition_n_str(s: String) -> String {
        let mut freq = HashMap::new();
        for c in s.chars() {
            *freq.entry(c).or_insert(0) += 1;
        }

        let mut result = Vec::new();
        let mut current = Vec::new();
        let mut current_freq = HashMap::new();

        for c in s.chars() {
            current.push(c);
            *current_freq.entry(c).or_insert(0) += 1;

            let mut valid = true;
            for (k, v) in &current_freq {
                if *v != *freq.get(k).unwrap() {
                    valid = false;
                    break;
                }
            }

            if valid {
                result.push(current.iter().collect::<String>());
                current.clear();
                current_freq.clear();
            }
        }

        result.join("")
    }
}
}