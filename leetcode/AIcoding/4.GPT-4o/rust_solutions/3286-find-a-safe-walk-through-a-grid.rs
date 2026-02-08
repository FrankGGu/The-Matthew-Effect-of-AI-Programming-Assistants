impl Solution {
    pub fn is_safe(grid: Vec<Vec<i32>>, x: usize, y: usize, n: usize, m: usize) -> bool {
        if x >= n || y >= m || grid[x][y] == 1 {
            return false;
        }
        let directions: [(isize, isize); 8] = [
            (-1, -1), (-1, 0), (-1, 1),
            (0, -1),         (0, 1),
            (1, -1), (1, 0), (1, 1),
        ];
        for (dx, dy) in directions.iter() {
            let mut nx = x as isize + dx;
            let mut ny = y as isize + dy;
            while nx >= 0 && nx < n as isize && ny >= 0 && ny < m as isize {
                if grid[nx as usize][ny as usize] == 1 {
                    return false;
                }
                nx += dx;
                ny += dy;
            }
        }
        true
    }

    pub fn find_safe_path(grid: Vec<Vec<i32>>) -> Vec<(usize, usize)> {
        let n = grid.len();
        let m = grid[0].len();
        let mut path = vec![];
        let mut visited = vec![vec![false; m]; n];

        fn dfs(x: usize, y: usize, n: usize, m: usize, grid: &Vec<Vec<i32>>, path: &mut Vec<(usize, usize)>, visited: &mut Vec<Vec<bool>>) -> bool {
            if x == n - 1 && y == m - 1 {
                path.push((x, y));
                return true;
            }
            visited[x][y] = true;
            path.push((x, y));
            let directions = [(0, 1), (1, 0), (0, -1), (-1, 0)];
            for (dx, dy) in directions.iter() {
                let nx = x as isize + *dx;
                let ny = y as isize + *dy;
                if nx >= 0 && nx < n as isize && ny >= 0 && ny < m as isize {
                    let (nx, ny) = (nx as usize, ny as usize);
                    if !visited[nx][ny] && Self::is_safe(grid.clone(), nx, ny, n, m) {
                        if dfs(nx, ny, n, m, grid, path, visited) {
                            return true;
                        }
                    }
                }
            }
            path.pop();
            visited[x][y] = false;
            false
        }

        if dfs(0, 0, n, m, &grid, &mut path, &mut visited) {
            path
        } else {
            vec![]
        }
    }
}