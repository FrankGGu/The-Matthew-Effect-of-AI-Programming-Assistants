impl Solution {
    pub fn check_if_grid_can_cut_into_sections(grid: Vec<Vec<i32>>, k: i32) -> bool {
        let m = grid.len();
        let n = grid[0].len();
        let mut visited = vec![vec![false; n]; m];

        fn dfs(grid: &Vec<Vec<i32>>, visited: &mut Vec<Vec<bool>>, i: usize, j: usize, k: i32) -> bool {
            let m = grid.len();
            let n = grid[0].len();

            if i >= m || j >= n || visited[i][j] || grid[i][j] == 0 {
                return true;
            }

            visited[i][j] = true;

            let mut count = 0;
            let mut queue = std::collections::VecDeque::new();
            queue.push_back((i, j));

            while let Some((row, col)) = queue.pop_front() {
                if row < m && col < n && grid[row][col] == 1 && !visited[row][col]{
                    visited[row][col] = true;
                    count += 1;
                    queue.push_back((row + 1, col));
                    queue.push_back((row - 1, col));
                    queue.push_back((row, col + 1));
                    queue.push_back((row, col - 1));
                }
            }

            if count < k {
                return false;
            }

            true
        }

        for i in 0..m {
            for j in 0..n {
                if grid[i][j] == 1 && !visited[i][j] {
                    if !dfs(&grid, &mut visited, i, j, k) {
                        return false;
                    }
                }
            }
        }

        true
    }
}