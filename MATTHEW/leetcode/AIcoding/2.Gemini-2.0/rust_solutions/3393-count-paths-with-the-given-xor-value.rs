use std::collections::HashMap;

impl Solution {
    pub fn count_paths(grid: Vec<Vec<i32>>, x: i32) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut memo: HashMap<(usize, usize, i32), i32> = HashMap::new();

        fn dfs(
            row: usize,
            col: usize,
            xor: i32,
            grid: &Vec<Vec<i32>>,
            x: i32,
            memo: &mut HashMap<(usize, usize, i32), i32>,
        ) -> i32 {
            if row == grid.len() - 1 && col == grid[0].len() - 1 {
                if (xor ^ grid[row][col]) == x {
                    return 1;
                } else {
                    return 0;
                }
            }

            if memo.contains_key(&(row, col, xor)) {
                return *memo.get(&(row, col, xor)).unwrap();
            }

            let mut count = 0;
            let new_xor = xor ^ grid[row][col];

            if row + 1 < grid.len() {
                count += dfs(row + 1, col, new_xor, grid, x, memo);
            }

            if col + 1 < grid[0].len() {
                count += dfs(row, col + 1, new_xor, grid, x, memo);
            }

            memo.insert((row, col, xor), count);
            count
        }

        dfs(0, 0, 0, &grid, x, &mut memo)
    }
}