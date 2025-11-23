use std::collections::HashMap;

impl Solution {
    pub fn melt_table(
        headers: Vec<String>,
        data: Vec<Vec<String>>,
        id_vars: Vec<String>,
        value_vars: Vec<String>,
        var_name: String,
        value_name: String,
    ) -> (Vec<String>, Vec<Vec<String>>) {
        let mut header_to_idx: HashMap<&str, usize> = HashMap::new();
        for (i, header) in headers.iter().enumerate() {
            header_to_idx.insert(header, i);
        }

        let mut id_var_indices: Vec<usize> = Vec::new();
        for id_var in &id_vars {
            if let Some(&idx) = header_to_idx.get(id_var.as_str()) {
                id_var_indices.push(idx);
            }
        }

        let mut value_var_indices_and_names: Vec<(usize, String)> = Vec::new();
        for value_var in &value_vars {
            if let Some(&idx) = header_to_idx.get(value_var.as_str()) {
                value_var_indices_and_names.push((idx, value_var.clone()));
            }
        }

        let mut new_headers: Vec<String> = Vec::new();
        new_headers.extend(id_vars.into_iter());
        new_headers.push(var_name);
        new_headers.push(value_name);

        let mut new_data: Vec<Vec<String>> = Vec::new();

        for row in data {
            let mut current_id_var_values: Vec<String> = Vec::new();
            for &idx in &id_var_indices {
                current_id_var_values.push(row[idx].clone());
            }

            for (val_idx, val_col_name) in &value_var_indices_and_names {
                let mut new_row_entry = current_id_var_values.clone();
                new_row_entry.push(val_col_name.clone());
                new_row_entry.push(row[*val_idx].clone());
                new_data.push(new_row_entry);
            }
        }

        (new_headers, new_data)
    }
}