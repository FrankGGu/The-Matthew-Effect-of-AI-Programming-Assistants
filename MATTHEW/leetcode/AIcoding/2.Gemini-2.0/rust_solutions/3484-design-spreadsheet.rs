use std::collections::HashMap;

struct Spreadsheet {
    grid: HashMap<(i32, i32), String>,
}

impl Spreadsheet {
    fn new(rows: i32, cols: i32) -> Self {
        Spreadsheet {
            grid: HashMap::new(),
        }
    }

    fn set(&mut self, row: i32, col: i32, s: String) {
        self.grid.insert((row, col), s);
    }

    fn get(&self, row: i32, col: i32) -> i32 {
        match self.grid.get(&(row, col)) {
            Some(s) => {
                if s.starts_with("=") {
                    self.evaluate(s.clone())
                } else {
                    match s.parse::<i32>() {
                        Ok(num) => num,
                        Err(_) => 0,
                    }
                }
            }
            None => 0,
        }
    }

    fn evaluate(&self, expression: String) -> i32 {
        let expression = expression.trim_start_matches("=");
        let mut sum = 0;
        for term in expression.split("+") {
            let term = term.trim();
            if term.len() == 2 && term.chars().all(|c| c.is_ascii_uppercase() || c.is_ascii_digit()) {
                let col = (term.chars().next().unwrap() as u8 - b'A') as i32;
                let row = term[1..].parse::<i32>().unwrap() - 1;
                sum += self.get(row, col);
            } else {
                sum += term.parse::<i32>().unwrap();
            }
        }
        sum
    }
}