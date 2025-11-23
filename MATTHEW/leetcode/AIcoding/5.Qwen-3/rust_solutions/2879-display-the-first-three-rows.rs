impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    fn display_first_three_rows(df: HashMap<String, Vec<i32>>) -> HashMap<String, Vec<i32>> {
        let mut result = HashMap::new();
        for (col, values) in df {
            if values.len() <= 3 {
                result.insert(col, values);
            } else {
                result.insert(col, values[..3].to_vec());
            }
        }
        result
    }
}
}