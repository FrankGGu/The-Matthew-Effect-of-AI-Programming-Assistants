impl Solution {

use std::collections::HashMap;

fn rename_columns(mut students: Vec<Vec<String>>) -> Vec<Vec<String>> {
    let mut map = HashMap::new();
    for (i, col) in students[0].iter().enumerate() {
        map.insert(col.clone(), i);
    }
    let new_columns = vec!["student_id".to_string(), "name".to_string(), "age".to_string()];
    let mut result = vec![Vec::new(); students.len()];
    for (i, row) in students.iter().enumerate() {
        for (j, col) in new_columns.iter().enumerate() {
            let idx = *map.get(col).unwrap();
            result[i].push(row[idx].clone());
        }
    }
    result
}
}