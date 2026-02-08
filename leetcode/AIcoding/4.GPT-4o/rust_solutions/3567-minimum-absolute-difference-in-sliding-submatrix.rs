use std::collections::BinaryHeap;

impl Solution {
    pub fn minimum_absolute_difference(mat: Vec<Vec<i32>>, row1: i32, col1: i32, row2: i32, col2: i32) -> i32 {
        let mut values = vec![];
        for i in row1..=row2 {
            for j in col1..=col2 {
                values.push(mat[i as usize][j as usize]);
            }
        }
        values.sort();
        let mut min_diff = i32::MAX;
        for i in 1..values.len() {
            min_diff = min_diff.min(values[i] - values[i - 1]);
        }
        min_diff
    }
}