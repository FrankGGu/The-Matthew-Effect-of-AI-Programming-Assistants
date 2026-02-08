impl Solution {
    pub fn minimum_area(grid: Vec<Vec<i32>>) -> i32 {
        let rows = grid.len();
        let cols = grid[0].len();

        let mut min_r = rows;
        let mut max_r = 0;
        let mut min_c = cols;
        let mut max_c = 0;

        for r in 0..rows {
            for c in 0..cols {
                if grid[r][c] == 1 {
                    min_r = std::cmp::min(min_r, r);
                    max_r = std::cmp::max(max_r, r);
                    min_c = std::cmp::min(min_c, c);
                    max_c = std::cmp::max(max_c, c);
                }
            }
        }

        let height = (max_r - min_r + 1) as i32;
        let width = (max_c - min_c + 1) as i32;

        height * width
    }
}