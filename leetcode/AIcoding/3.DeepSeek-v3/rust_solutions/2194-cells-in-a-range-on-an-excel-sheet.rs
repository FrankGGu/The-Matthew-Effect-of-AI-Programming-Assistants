impl Solution {
    pub fn cells_in_range(s: String) -> Vec<String> {
        let mut res = Vec::new();
        let chars: Vec<char> = s.chars().collect();
        let start_col = chars[0] as u8;
        let start_row = chars[1] as u8;
        let end_col = chars[3] as u8;
        let end_row = chars[4] as u8;

        for col in start_col..=end_col {
            for row in start_row..=end_row {
                let mut cell = String::new();
                cell.push(col as char);
                cell.push(row as char);
                res.push(cell);
            }
        }

        res
    }
}