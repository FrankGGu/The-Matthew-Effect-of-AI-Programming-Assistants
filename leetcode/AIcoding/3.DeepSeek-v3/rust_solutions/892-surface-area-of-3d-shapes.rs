impl Solution {
    pub fn surface_area(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut area = 0;
        for i in 0..n {
            for j in 0..n {
                let height = grid[i][j];
                if height > 0 {
                    area += 2;
                    for &(di, dj) in &[(-1, 0), (1, 0), (0, -1), (0, 1)] {
                        let ni = i as i32 + di;
                        let nj = j as i32 + dj;
                        let mut neighbor_height = 0;
                        if ni >= 0 && ni < n as i32 && nj >= 0 && nj < n as i32 {
                            neighbor_height = grid[ni as usize][nj as usize];
                        }
                        area += std::cmp::max(height - neighbor_height, 0);
                    }
                }
            }
        }
        area
    }
}