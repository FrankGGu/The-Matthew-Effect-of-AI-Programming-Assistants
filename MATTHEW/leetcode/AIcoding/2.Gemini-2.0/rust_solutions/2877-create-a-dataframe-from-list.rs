use std::collections::HashMap;

struct DataFrame {
    data: Vec<HashMap<String, String>>,
    column_names: Vec<String>,
}

impl DataFrame {
    fn new(data: Vec<Vec<String>>, column_names: Vec<String>) -> Self {
        let mut df_data: Vec<HashMap<String, String>> = Vec::new();
        for row in data {
            let mut row_map: HashMap<String, String> = HashMap::new();
            for (i, col_name) in column_names.iter().enumerate() {
                row_map.insert(col_name.clone(), row[i].clone());
            }
            df_data.push(row_map);
        }

        DataFrame {
            data: df_data,
            column_names,
        }
    }
}