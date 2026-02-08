impl Solution {
    pub fn can_stamp(grid: Vec<Vec<i32>>, stamp_height: i32, stamp_width: i32) -> bool {
        let (rows, cols) = (grid.len(), grid[0].len());
        let (h, w) = (stamp_height as usize, stamp_width as usize);

        let mut covered = vec![vec![false; cols]; rows];

        for i in 0..rows {
            for j in 0..cols {
                if grid[i][j] == 1 {
                    for x in i..(i + h).min(rows) {
                        for y in j..(j + w).min(cols) {
                            covered[x][y] = true;
                        }
                    }
                }
            }
        }

        for i in 0..rows {
            for j in 0..cols {
                if !covered[i][j] && grid[i][j] == 0 {
                    return false;
                }
            }
        }

        true
    }
}