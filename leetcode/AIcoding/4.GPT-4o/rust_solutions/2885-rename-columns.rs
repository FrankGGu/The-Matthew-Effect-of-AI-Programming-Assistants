use std::collections::HashMap;

pub fn rename_columns(columns: Vec<String>, name: String) -> Vec<String> {
    let mut col_map: HashMap<String, usize> = HashMap::new();
    let mut result = Vec::new();

    for col in columns.iter() {
        let mut new_col = col.clone();
        let mut count = 1;

        while col_map.contains_key(&new_col) {
            new_col = format!("{}{}", col, count);
            count += 1;
        }

        col_map.insert(new_col.clone(), 1);
        result.push(new_col);
    }

    result
}