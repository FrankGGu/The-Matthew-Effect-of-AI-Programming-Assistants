impl Solution {
    pub fn region_average(grid: Vec<Vec<i32>>, r: i32, c: i32, k: i32) -> Vec<Vec<f64>> {
        let rows = grid.len();
        let cols = grid[0].len();
        let mut result = vec![vec![0.0; cols]; rows];

        let r = r as usize;
        let c = c as usize;
        let k = k as usize;

        for i in 0..rows {
            for j in 0..cols {
                let mut total = 0;
                let mut count = 0;

                for x in (i as isize - k as isize).max(0) as usize..=(i + k as usize).min(rows - 1) {
                    for y in (j as isize - k as isize).max(0) as usize..=(j + k as usize).min(cols - 1) {
                        if (x as isize - i as isize).abs() + (y as isize - j as isize).abs() <= k as isize {
                            total += grid[x][y];
                            count += 1;
                        }
                    }
                }
                result[i][j] = total as f64 / count as f64;
            }
        }

        result
    }
}