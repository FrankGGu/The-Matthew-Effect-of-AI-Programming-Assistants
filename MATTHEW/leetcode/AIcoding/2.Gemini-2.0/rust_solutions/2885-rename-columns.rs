use std::collections::HashMap;

impl Solution {
    pub fn rename_columns(data: Vec<Vec<String>>, columns: Vec<String>) -> Vec<Vec<String>> {
        let mut result: Vec<Vec<String>> = Vec::new();
        if data.is_empty() {
            return result;
        }

        let mut header: Vec<String> = Vec::new();
        for col in columns {
            header.push(col);
        }
        result.push(header);

        for i in 1..data.len() {
            result.push(data[i].clone());
        }

        result
    }
}