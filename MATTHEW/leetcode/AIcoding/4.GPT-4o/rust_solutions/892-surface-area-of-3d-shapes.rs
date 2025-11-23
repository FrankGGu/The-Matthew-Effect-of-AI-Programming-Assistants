impl Solution {
    pub fn surface_area(grid: Vec<Vec<i32>>) -> i32 {
        let mut total_surface_area = 0;
        let directions = vec![(1, 0), (0, 1), (-1, 0), (0, -1)];

        for i in 0..grid.len() {
            for j in 0..grid[0].len() {
                if grid[i][j] > 0 {
                    total_surface_area += 2; // top and bottom
                    total_surface_area += grid[i][j] * 4; // all sides

                    for (dx, dy) in &directions {
                        let ni = (i as isize + dx) as usize;
                        let nj = (j as isize + dy) as usize;
                        if ni < grid.len() && nj < grid[0].len() {
                            total_surface_area -= grid[i][j].min(grid[ni][nj]);
                        }
                    }
                }
            }
        }

        total_surface_area
    }
}