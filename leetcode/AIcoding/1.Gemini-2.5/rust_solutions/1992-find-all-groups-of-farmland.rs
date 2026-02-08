impl Solution {
    pub fn find_farmland(mut grid: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let m = grid.len();
        if m == 0 {
            return vec![];
        }
        let n = grid[0].len();
        if n == 0 {
            return vec![];
        }

        let mut result = Vec::new();

        for r in 0..m {
            for c in 0..n {
                if grid[r][c] == 1 {
                    // This is the top-left corner of a new farmland group
                    let r_start = r;
                    let c_start = c;

                    // Find the bottom-right corner of the rectangular group
                    // First, find the rightmost column for this row (r_start)
                    let mut c_end = c;
                    while c_end + 1 < n && grid[r_start][c_end + 1] == 1 {
                        c_end += 1;
                    }

                    // Then, find the bottommost row for this column (c_start)
                    let mut r_end = r;
                    while r_end + 1 < m && grid[r_end + 1][c_start] == 1 {
                        r_end += 1;
                    }

                    // Add the coordinates of the farmland group to the result
                    result.push(vec![r_start as i32, c_start as i32, r_end as i32, c_end as i32]);

                    // Mark all cells within this identified rectangle as visited (0)
                    // to prevent re-processing them as new farmland groups.
                    for i in r_start..=r_end {
                        for j in c_start..=c_end {
                            grid[i][j] = 0;
                        }
                    }
                }
            }
        }
        result
    }
}