pub fn cells_in_range(s: String) -> Vec<String> {
    let chars: Vec<char> = s.chars().collect();
    let start_col = chars[0];
    let start_row = chars[1].to_digit(10).unwrap();
    let end_col = chars[3];
    let end_row = chars[4].to_digit(10).unwrap();

    let mut result = Vec::new();

    for c in start_col..=end_col {
        for r in start_row..=end_row {
            result.push(format!("{}{}", c, r));
        }
    }

    result
}