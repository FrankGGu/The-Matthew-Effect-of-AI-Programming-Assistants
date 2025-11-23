impl Solution {

use std::collections::HashMap;

#[derive(Debug, Clone, PartialEq)]
pub struct DataFrame {
    pub data: Vec<Vec<String>>,
    pub columns: Vec<String>,
}

impl DataFrame {
    pub fn new(columns: Vec<String>, data: Vec<Vec<String>>) -> Self {
        DataFrame { columns, data }
    }

    pub fn melt(mut self) -> Self {
        let mut result_data = Vec::new();
        let mut result_columns = vec!["variable".to_string(), "value".to_string()];

        let mut variable_map = HashMap::new();

        for (i, col) in self.columns.iter().enumerate() {
            variable_map.insert(col, i);
        }

        for row in self.data {
            for (col_idx, col_name) in &self.columns {
                let value = row[*col_idx].clone();
                result_data.push(vec![
                    col_name.clone(),
                    value,
                ]);
            }
        }

        DataFrame::new(result_columns, result_data)
    }
}

pub fn melt_dataframe(df: DataFrame) -> DataFrame {
    df.melt()
}
}