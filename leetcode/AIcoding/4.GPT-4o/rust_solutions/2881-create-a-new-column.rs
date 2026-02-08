use std::collections::HashMap;

pub fn create_new_column(data: Vec<Vec<i32>>, col_name: &str) -> Vec<Vec<i32>> {
    let mut new_data = data.clone();
    let (n, m) = (new_data.len(), new_data[0].len());

    let mut sums = HashMap::new();

    for row in 0..n {
        let key = new_data[row][0];
        *sums.entry(key).or_insert(0) += new_data[row][1];
    }

    for row in 0..n {
        new_data[row].push(*sums.get(&new_data[row][0]).unwrap());
    }

    new_data
}