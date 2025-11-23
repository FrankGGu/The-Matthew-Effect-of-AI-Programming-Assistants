use std::collections::HashMap;

struct DataFrame {
    data: HashMap<String, Vec<String>>,
}

impl DataFrame {
    fn new() -> Self {
        DataFrame {
            data: HashMap::new(),
        }
    }

    fn from_list(list: Vec<Vec<String>>) -> Self {
        let mut df = DataFrame::new();
        if list.is_empty() {
            return df;
        }

        let columns = list[0].len();
        for row in list {
            for i in 0..columns {
                df.data.entry(i.to_string()).or_insert_with(Vec::new).push(row[i].clone());
            }
        }
        df
    }

    fn to_list(&self) -> Vec<Vec<String>> {
        let mut rows = Vec::new();
        let column_count = self.data.len();
        let row_count = self.data.values().next().map_or(0, |v| v.len());

        for i in 0..row_count {
            let mut row = Vec::new();
            for j in 0..column_count {
                if let Some(values) = self.data.get(&j.to_string()) {
                    row.push(values[i].clone());
                }
            }
            rows.push(row);
        }
        rows
    }
}