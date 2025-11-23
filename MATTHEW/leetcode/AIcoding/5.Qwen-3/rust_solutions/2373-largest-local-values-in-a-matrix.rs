impl Solution {
    pub fn largest_local(grid: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let n = grid.len();
        let mut result = vec![vec![0; n - 1]; n - 1];

        for i in 0..n - 1 {
            for j in 0..n - 1 {
                let mut max_val = 0;
                for x in 0..2 {
                    for y in 0..2 {
                        max_val = max_val.max(grid[i + x][j + y]);
                    }
                }
                result[i][j] = max_val;
            }
        }

        result
    }
}