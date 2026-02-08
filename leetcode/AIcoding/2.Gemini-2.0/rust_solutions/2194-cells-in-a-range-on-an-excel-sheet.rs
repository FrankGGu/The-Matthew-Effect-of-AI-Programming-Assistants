impl Solution {
    pub fn cells_in_range(s: String) -> Vec<String> {
        let chars: Vec<char> = s.chars().collect();
        let col1 = chars[0] as u8;
        let row1 = chars[1].to_digit(10).unwrap() as u8;
        let col2 = chars[3] as u8;
        let row2 = chars[4].to_digit(10).unwrap() as u8;

        let mut result: Vec<String> = Vec::new();

        for col in col1..=col2 {
            for row in row1..=row2 {
                let cell = format!("{}{}", col as char, row);
                result.push(cell);
            }
        }

        result
    }
}