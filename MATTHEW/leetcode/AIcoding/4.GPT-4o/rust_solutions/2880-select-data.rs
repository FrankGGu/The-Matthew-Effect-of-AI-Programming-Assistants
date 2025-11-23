use std::collections::HashMap;

pub fn select_data(data: Vec<Vec<i32>>, target: i32) -> Vec<Vec<i32>> {
    let mut result = Vec::new();
    let mut count_map: HashMap<i32, usize> = HashMap::new();

    for row in &data {
        let key = row[0];
        let count = count_map.entry(key).or_insert(0);
        *count += 1;
    }

    for row in data {
        if count_map[&row[0]] == target as usize {
            result.push(row);
        }
    }

    result
}