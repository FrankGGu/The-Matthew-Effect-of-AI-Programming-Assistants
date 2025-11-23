struct Spreadsheet {
    rows: usize,
    cols: usize,
    cells: Vec<Vec<String>>,
}

impl Spreadsheet {
    fn new(m: i32, n: i32) -> Self {
        let rows = m as usize;
        let cols = n as usize;
        let cells = vec![vec![String::new(); cols]; rows];
        Spreadsheet { rows, cols, cells }
    }

    fn set_value(&mut self, r: i32, c: i32, v: String) {
        let r = r as usize;
        let c = c as usize;
        self.cells[r][c] = v;
    }

    fn get_value(&self, r: i32, c: i32) -> String {
        let r = r as usize;
        let c = c as usize;
        self.cells[r][c].clone()
    }

    fn get_values(&self, r: i32, c: i32, h: i32, w: i32) -> Vec<Vec<String>> {
        let r = r as usize;
        let c = c as usize;
        let h = h as usize;
        let w = w as usize;
        let mut result = Vec::with_capacity(h);
        for i in 0..h {
            let mut row = Vec::with_capacity(w);
            for j in 0..w {
                row.push(self.cells[r + i][c + j].clone());
            }
            result.push(row);
        }
        result
    }
}