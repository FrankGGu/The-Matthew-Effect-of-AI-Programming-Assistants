impl Solution {
    pub fn convert(s: String, num_rows: i32) -> String {
        if num_rows == 1 || s.len() <= num_rows as usize {
            return s;
        }

        let num_rows = num_rows as usize;
        let mut rows: Vec<Vec<char>> = vec![Vec::new(); num_rows];

        let mut current_row = 0;
        let mut going_down = false; 

        for c in s.chars() {
            rows[current_row].push(c);

            if current_row == 0 || current_row == num_rows - 1 {
                going_down = !going_down;
            }

            if going_down {
                current_row += 1;
            } else {
                current_row -= 1;
            }
        }

        let mut result = String::new();
        for row in rows {
            for c in row {
                result.push(c);
            }
        }
        result
    }
}