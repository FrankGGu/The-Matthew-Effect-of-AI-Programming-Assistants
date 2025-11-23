impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn get_unique_file_name(mut names: Vec<String>) -> Vec<String> {
        let mut count = HashMap::new();
        let mut result = Vec::with_capacity(names.len());

        for name in names {
            if let Some(&c) = count.get(&name) {
                let new_name = format!("{}({})", name, c);
                result.push(new_name);
                *count.entry(name).or_insert(0) += 1;
                *count.entry(new_name.clone()).or_insert(0) += 1;
            } else {
                result.push(name.clone());
                *count.entry(name).or_insert(0) += 1;
            }
        }

        result
    }
}
}