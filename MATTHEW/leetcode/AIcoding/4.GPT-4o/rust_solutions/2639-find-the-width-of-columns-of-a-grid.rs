pub fn find_column_width(grid: Vec<Vec<String>>) -> Vec<i32> {
    let mut widths = vec![0; grid[0].len()];
    for row in grid {
        for (i, val) in row.iter().enumerate() {
            widths[i] = widths[i].max(val.len() as i32);
        }
    }
    widths
}