use std::collections::HashMap;

use serde::{Deserialize, Serialize};

#[derive(Debug, Serialize, Deserialize)]
pub struct DataFrame {
    pub headers: Vec<String>,
    pub values: Vec<Vec<String>>,
}

impl DataFrame {
    pub fn new(headers: Vec<String>, values: Vec<Vec<String>>) -> Self {
        DataFrame { headers, values }
    }
}

fn pivot_table(df: DataFrame, pivot_col: String, value_col: String) -> DataFrame {
    let headers = df.headers;
    let values = df.values;

    let pivot_index = headers.iter().position(|h| h == &pivot_col).unwrap();
    let value_index = headers.iter().position(|h| h == &value_col).unwrap();

    let mut row_values = Vec::new();
    let mut col_values = Vec::new();
    let mut data = HashMap::new();

    for row in &values {
        let row_value = row[0].clone();
        let col_value = row[pivot_index].clone();
        let value = row[value_index].clone();

        if !row_values.contains(&row_value) {
            row_values.push(row_value.clone());
        }
        if !col_values.contains(&col_value) {
            col_values.push(col_value.clone());
        }

        data.insert((row_value, col_value), value);
    }

    col_values.sort();
    row_values.sort();

    let mut new_headers = vec![headers[0].clone()];
    new_headers.extend(col_values.clone());

    let mut new_values = Vec::new();
    for row_value in &row_values {
        let mut new_row = vec![row_value.clone()];
        for col_value in &col_values {
            let value = data.get(&(row_value.clone(), col_value.clone())).cloned().unwrap_or("0".to_string());
            new_row.push(value);
        }
        new_values.push(new_row);
    }

    DataFrame::new(new_headers, new_values)
}