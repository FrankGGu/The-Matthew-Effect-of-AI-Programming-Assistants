impl Solution {
    pub fn zigzag_traversal_with_skip(grid: Vec<Vec<i32>>, skip: i32) -> Vec<i32> {
        let m = grid.len();
        if m == 0 {
            return vec![];
        }
        let n = grid[0].len();
        let mut result = Vec::new();
        let mut i = 0;
        let mut j = 0;
        let mut direction = 1; // 1 for up-right, -1 for down-left
        let mut count = 0;

        loop {
            if i < m && j < n {
                if count % (skip + 1) != 0 {
                    result.push(grid[i][j]);
                }
                count += 1;
            }

            if direction == 1 {
                if j == n - 1 {
                    i += 1;
                    direction = -1;
                } else if i == 0 {
                    j += 1;
                    direction = -1;
                } else {
                    i -= 1;
                    j += 1;
                }
            } else {
                if i == m - 1 {
                    j += 1;
                    direction = 1;
                } else if j == 0 {
                    i += 1;
                    direction = 1;
                } else {
                    i += 1;
                    j -= 1;
                }
            }

            if i >= m || j >= n {
                break;
            }
        }

        result
    }
}