use std::collections::HashMap;

struct Excel {
    cells: HashMap<(i32, char), Cell>,
}

enum Cell {
    Value(i32),
    Formula(Vec<(i32, char)>, String),
}

impl Excel {
    fn new(height: i32, width: char) -> Self {
        Excel {
            cells: HashMap::new(),
        }
    }

    fn set(&mut self, row: i32, column: char, val: i32) {
        self.cells.insert((row, column), Cell::Value(val));
    }

    fn get(&self, row: i32, column: char) -> i32 {
        self.evaluate(&(row, column))
    }

    fn sum(&mut self, row: i32, column: char, numbers: Vec<String>) -> i32 {
        let mut sum = 0;
        let mut refs = Vec::new();
        for num in numbers {
            if num.contains(':') {
                let parts: Vec<&str> = num.split(':').collect();
                let start_col = parts[0].chars().next().unwrap();
                let start_row: i32 = parts[0][1..].parse().unwrap();
                let end_col = parts[1].chars().next().unwrap();
                let end_row: i32 = parts[1][1..].parse().unwrap();

                for r in start_row..=end_row {
                    for c in start_col..=end_col {
                        sum += self.evaluate(&(r, c));
                        refs.push((r, c));
                    }
                }
            } else {
                let col = num.chars().next().unwrap();
                let row: i32 = num[1..].parse().unwrap();
                sum += self.evaluate(&(row, col));
                refs.push((row, col));
            }
        }
        self.cells.insert((row, column), Cell::Formula(refs, "SUM".to_string()));
        sum
    }

    fn evaluate(&self, pos: &(i32, char)) -> i32 {
        match self.cells.get(pos) {
            Some(Cell::Value(val)) => *val,
            Some(Cell::Formula(refs, op)) => {
                match op.as_str() {
                    "SUM" => {
                        let mut sum = 0;
                        for r in refs {
                            sum += self.evaluate(r);
                        }
                        sum
                    },
                    _ => 0,
                }
            },
            None => 0,
        }
    }
}