impl Solution {
    pub fn island_perimeter(grid: Vec<Vec<i32>>) -> i32 {
        let mut perimeter = 0;
        let directions = vec![(1, 0), (-1, 0), (0, 1), (0, -1)];

        for i in 0..grid.len() {
            for j in 0..grid[0].len() {
                if grid[i][j] == 1 {
                    for (dx, dy) in &directions {
                        let ni = (i as isize + dx) as usize;
                        let nj = (j as isize + dy) as usize;
                        if ni >= grid.len() || nj >= grid[0].len() || grid[ni][nj] == 0 {
                            perimeter += 1;
                        }
                    }
                }
            }
        }

        perimeter
    }
}