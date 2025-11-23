pub fn sand_management(grid: Vec<Vec<i32>>) -> i32 {
    let mut total_sand = 0;
    let mut total_cells = 0;

    for row in &grid {
        for &cell in row {
            total_sand += cell;
            total_cells += 1;
        }
    }

    total_sand / total_cells
}