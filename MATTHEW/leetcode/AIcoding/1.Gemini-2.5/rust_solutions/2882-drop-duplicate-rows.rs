use std::collections::HashSet;

impl Solution {
    pub fn drop_duplicate_rows(rows: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut unique_rows_set: HashSet<Vec<i32>> = HashSet::new();
        let mut result: Vec<Vec<i32>> = Vec::new();

        for row in rows {
            if unique_rows_set.insert(row.clone()) {
                result.push(row);
            }
        }
        result
    }
}