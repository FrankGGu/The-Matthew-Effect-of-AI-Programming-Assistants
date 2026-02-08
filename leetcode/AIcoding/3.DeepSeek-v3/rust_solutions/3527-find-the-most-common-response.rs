use std::collections::HashMap;

impl Solution {
    pub fn most_common_response(records: Vec<Vec<i32>>) -> i32 {
        let mut map = HashMap::new();
        for record in records {
            let response = record[1];
            *map.entry(response).or_insert(0) += 1;
        }
        let mut max_count = 0;
        let mut result = 0;
        for (&response, &count) in map.iter() {
            if count > max_count || (count == max_count && response < result) {
                max_count = count;
                result = response;
            }
        }
        result
    }
}