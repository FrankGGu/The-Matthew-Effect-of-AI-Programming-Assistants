use std::collections::HashSet;

pub fn delete_duplicate_rows(mut rows: Vec<Vec<String>>) -> Vec<Vec<String>> {
    let mut seen = HashSet::new();
    let mut result = Vec::new();

    for row in rows {
        let row_tuple: Vec<_> = row.iter().collect();
        if seen.insert(row_tuple.clone()) {
            result.push(row);
        }
    }

    result
}