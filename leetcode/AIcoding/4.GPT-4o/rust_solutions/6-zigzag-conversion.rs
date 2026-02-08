pub fn convert(s: String, num_rows: i32) -> String {
    if num_rows == 1 || num_rows >= s.len() as i32 {
        return s;
    }

    let mut rows = vec![String::new(); num_rows as usize];
    let mut current_row = 0;
    let mut going_down = false;

    for c in s.chars() {
        rows[current_row].push(c);
        if current_row == 0 {
            going_down = true;
        } else if current_row == (num_rows - 1) {
            going_down = false;
        }
        current_row += if going_down { 1 } else { -1 };
    }

    rows.concat()
}