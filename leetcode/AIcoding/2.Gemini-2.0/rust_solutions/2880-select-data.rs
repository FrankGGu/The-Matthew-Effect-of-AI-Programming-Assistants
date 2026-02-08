use std::collections::HashMap;

fn select_data(data: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
    let mut result: Vec<Vec<i32>> = Vec::new();
    for row in data {
        if row[2] > 41 {
            result.push(row);
        }
    }
    result
}