use std::collections::HashMap;

struct Spreadsheet {
    cells: HashMap<(i32, i32), String>,
}

impl Spreadsheet {
    fn new() -> Self {
        Spreadsheet {
            cells: HashMap::new(),
        }
    }

    fn set(&mut self, row: i32, col: i32, value: String) {
        self.cells.insert((row, col), value);
    }

    fn get(&self, row: i32, col: i32) -> String {
        match self.cells.get(&(row, col)) {
            Some(value) => value.clone(),
            None => "EMPTY".to_string(),
        }
    }

    fn sum(&mut self, row: i32, col: i32, ranges: Vec<String>) {
        let mut total = 0;
        for range in ranges {
            let parts: Vec<&str> = range.split(':').collect();
            let start = parts[0];
            let end = parts[1];

            let start_row = start[0..start.len()-1].parse::<i32>().unwrap();
            let start_col = start[start.len()-1..].chars().next().unwrap() as i32 - 'A' as i32 + 1;
            let end_row = end[0..end.len()-1].parse::<i32>().unwrap();
            let end_col = end[end.len()-1..].chars().next().unwrap() as i32 - 'A' as i32 + 1;

            for r in start_row..=end_row {
                for c in start_col..=end_col {
                    total += self.cells.get(&(r, c)).and_then(|v| v.parse::<i32>().ok()).unwrap_or(0);
                }
            }
        }
        self.cells.insert((row, col), total.to_string());
    }
}