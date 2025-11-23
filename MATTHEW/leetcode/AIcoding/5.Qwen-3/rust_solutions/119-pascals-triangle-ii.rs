impl Solution {

use std::vec;

pub fn get_row(row_index: i32) -> Vec<i32> {
    let mut row = vec![1];
    for i in 1..=row_index as usize {
        let mut new_row = vec![1];
        for j in 1..i {
            new_row.push(row[j - 1] + row[j]);
        }
        new_row.push(1);
        row = new_row;
    }
    row
}
}