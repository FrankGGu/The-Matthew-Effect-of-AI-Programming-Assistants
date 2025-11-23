use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn concatenate(
        df1: Vec<HashMap<String, String>>,
        df2: Vec<HashMap<String, String>>,
    ) -> Vec<HashMap<String, String>> {
        let mut result = df1;
        result.extend(df2);
        result
    }
}