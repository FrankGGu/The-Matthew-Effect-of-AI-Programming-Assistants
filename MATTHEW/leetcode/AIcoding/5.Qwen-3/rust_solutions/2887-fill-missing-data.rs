impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn fill_missing_data(values: Vec<Option<i32>>) -> Vec<i32> {
        let mut map = HashMap::new();
        let mut result = Vec::with_capacity(values.len());
        let mut current = 0;

        for val in values {
            match val {
                Some(v) => {
                    current = v;
                    result.push(current);
                    map.insert(current, ());
                },
                None => {
                    while map.contains_key(&current) {
                        current += 1;
                    }
                    result.push(current);
                    map.insert(current, ());
                }
            }
        }

        result
    }
}
}