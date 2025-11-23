impl Solution {

use std::collections::HashMap;

#[derive(Debug, Clone, PartialEq, Eq)]
struct DataFrame {
    data: HashMap<String, Vec<i32>>,
}

fn get_size(df: &DataFrame) -> (i32, i32) {
    let rows = df.data.values().next().map_or(0, |v| v.len() as i32);
    let cols = df.data.len() as i32;
    (rows, cols)
}
}