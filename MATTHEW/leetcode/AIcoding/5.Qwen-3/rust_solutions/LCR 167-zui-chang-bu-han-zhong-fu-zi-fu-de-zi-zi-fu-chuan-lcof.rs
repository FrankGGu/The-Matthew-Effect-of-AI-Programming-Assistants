impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn find_formation(attack_records: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut map = HashMap::new();
        for record in attack_records {
            let key = (record[0], record[1]);
            let value = map.entry(key).or_insert_with(Vec::new);
            value.push(record[2]);
        }

        let mut result = Vec::new();
        for (_, values) in map {
            let mut sorted = values;
            sorted.sort();
            result.push(sorted);
        }

        result
    }
}
}