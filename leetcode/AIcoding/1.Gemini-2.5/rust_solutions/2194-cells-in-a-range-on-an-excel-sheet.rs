impl Solution {
    pub fn cells_in_range(s: String) -> Vec<String> {
        let chars: Vec<char> = s.chars().collect();
        let col1 = chars[0];
        let row1 = chars[1];
        let col2 = chars[3];
        let row2 = chars[4];

        let mut result = Vec::new();

        for c in col1..=col2 {
            for r in row1..=row2 {
                let mut cell = String::with_capacity(2);
                cell.push(c);
                cell.push(r);
                result.push(cell);
            }
        }

        result
    }
}