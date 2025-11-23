impl Solution {
    pub fn difference_of_distinct_values(grid: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let m = grid.len();
        let n = grid[0].len();
        let mut res = vec![vec![0; n]; m];

        for i in 0..m {
            for j in 0..n {
                let mut top_left = std::collections::HashSet::new();
                let mut r = i as i32 - 1;
                let mut c = j as i32 - 1;
                while r >= 0 && c >= 0 {
                    top_left.insert(grid[r as usize][c as usize]);
                    r -= 1;
                    c -= 1;
                }

                let mut bottom_right = std::collections::HashSet::new();
                let mut r = i + 1;
                let mut c = j + 1;
                while r < m && c < n {
                    bottom_right.insert(grid[r][c]);
                    r += 1;
                    c += 1;
                }

                res[i][j] = (top_left.len() as i32 - bottom_right.len() as i32).abs();
            }
        }

        res
    }
}