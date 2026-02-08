struct Solution;

impl Solution {
    pub fn max_area_of_island(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        if m == 0 {
            return 0;
        }
        let n = grid[0].len();
        if n == 0 {
            return 0;
        }

        let mut visited = vec![vec![false; n]; m];
        let mut max_area = 0;

        for r in 0..m {
            for c in 0..n {
                if grid[r][c] == 1 && !visited[r][c] {
                    let current_area = Self::dfs(r as i32, c as i32, &grid, &mut visited, m as i32, n as i32);
                    max_area = max_area.max(current_area);
                }
            }
        }
        max_area
    }

    fn dfs(r: i32, c: i32, grid: &Vec<Vec<i32>>, visited: &mut Vec<Vec<bool>>, m: i32, n: i32) -> i32 {
        if r < 0 || r >= m || c < 0 || c >= n || grid[r as usize][c as usize] == 0 || visited[r as usize][c as usize] {
            return 0;
        }

        visited[r as usize][c as usize] = true;
        let mut current_area = 1;

        current_area += Self::dfs(r + 1, c, grid, visited, m, n);
        current_area += Self::dfs(r - 1, c, grid, visited, m, n);
        current_area += Self::dfs(r, c + 1, grid, visited, m, n);
        current_area += Self::dfs(r, c - 1, grid, visited, m, n);

        current_area
    }
}