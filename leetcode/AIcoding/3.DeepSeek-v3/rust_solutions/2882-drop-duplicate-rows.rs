use std::collections::HashSet;

impl Solution {
    pub fn drop_duplicate_rows(dataframe: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut seen = HashSet::new();
        let mut result = Vec::new();

        for row in dataframe {
            if seen.insert(row.clone()) {
                result.push(row);
            }
        }

        result
    }
}