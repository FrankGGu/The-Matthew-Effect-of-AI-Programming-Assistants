impl Solution {
    pub fn pivot(df: Vec<Vec<i32>>, col: String, values: Vec<String>) -> Vec<Vec<String>> {
        use std::collections::HashMap;

        let col_idx = col.parse::<usize>().unwrap();
        let mut value_indices: Vec<usize> = values.iter().map(|v| v.parse::<usize>().unwrap()).collect();
        value_indices.sort();

        let mut pivoted = Vec::new();
        let mut header = Vec::new();
        let mut rows_map: HashMap<Vec<String>, Vec<String>> = HashMap::new();

        // Build header
        header.push(df[0][col_idx].to_string());
        for &idx in &value_indices {
            header.push(df[0][idx].to_string());
        }
        pivoted.push(header);

        // Process data rows
        for row in df.iter().skip(1) {
            let key = row[col_idx].to_string();
            let mut new_row = Vec::new();
            new_row.push(key.clone());

            for &idx in &value_indices {
                new_row.push(row[idx].to_string());
            }

            pivoted.push(new_row);
        }

        pivoted
    }
}