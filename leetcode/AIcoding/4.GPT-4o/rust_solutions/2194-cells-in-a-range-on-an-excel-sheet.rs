impl Solution {
    pub fn cells_in_range(s: String) -> Vec<String> {
        let chars: Vec<char> = s.chars().collect();
        let start_col = chars[0];
        let end_col = chars[3];
        let start_row: u32 = chars[1].to_digit(10).unwrap();
        let end_row: u32 = chars[4].to_digit(10).unwrap();

        let mut result = Vec::new();

        for col in start_col..=end_col {
            for row in start_row..=end_row {
                result.push(format!("{}{}", col, row));
            }
        }

        result
    }
}