impl Solution {
    pub fn tiling_rectangle(n: i32, m: i32) -> i32 {
        let mut res = std::i32::MAX;
        let mut grid = vec![vec![false; m as usize]; n as usize];
        Self::dfs(0, 0, &mut grid, 0, &mut res);
        res
    }

    fn dfs(x: usize, y: usize, grid: &mut Vec<Vec<bool>>, cnt: i32, res: &mut i32) {
        let n = grid.len();
        let m = grid[0].len();

        if cnt >= *res {
            return;
        }

        if x >= n {
            *res = cnt;
            return;
        }

        if y >= m {
            Self::dfs(x + 1, 0, grid, cnt, res);
            return;
        }

        if grid[x][y] {
            Self::dfs(x, y + 1, grid, cnt, res);
            return;
        }

        let max_possible = (n - x).min(m - y);
        for k in (1..=max_possible).rev() {
            if Self::is_available(x, y, k, grid) {
                Self::fill(x, y, k, true, grid);
                Self::dfs(x, y + k, grid, cnt + 1, res);
                Self::fill(x, y, k, false, grid);
            }
        }
    }

    fn is_available(x: usize, y: usize, k: usize, grid: &Vec<Vec<bool>>) -> bool {
        for i in x..x + k {
            for j in y..y + k {
                if grid[i][j] {
                    return false;
                }
            }
        }
        true
    }

    fn fill(x: usize, y: usize, k: usize, val: bool, grid: &mut Vec<Vec<bool>>) {
        for i in x..x + k {
            for j in y..y + k {
                grid[i][j] = val;
            }
        }
    }
}