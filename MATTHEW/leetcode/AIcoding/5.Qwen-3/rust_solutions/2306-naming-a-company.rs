impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn distinct_names(mut names: Vec<String>) -> i32 {
        let mut prefix_map = HashMap::new();
        let mut suffix_map = HashMap::new();

        for name in &names {
            let first_char = name.chars().next().unwrap();
            let last_char = name.chars().rev().next().unwrap();

            *prefix_map.entry(first_char).or_insert(0) += 1;
            *suffix_map.entry(last_char).or_insert(0) += 1;
        }

        let mut result = 0;

        for (prefix, count_prefix) in &prefix_map {
            for (suffix, count_suffix) in &suffix_map {
                if prefix != suffix {
                    result += count_prefix * count_suffix;
                }
            }
        }

        result
    }
}
}