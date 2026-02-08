impl Solution {
    pub fn convert(s: String, num_rows: i32) -> String {
        if num_rows == 1 {
            return s;
        }

        let mut rows: Vec<String> = vec![String::new(); num_rows as usize];
        let mut current_row: i32 = 0;
        let mut going_down: bool = false;

        for c in s.chars() {
            rows[current_row as usize].push(c);

            if current_row == 0 || current_row == num_rows - 1 {
                going_down = !going_down;
            }

            current_row += if going_down { 1 } else { -1 };
        }

        rows.join("")
    }
}