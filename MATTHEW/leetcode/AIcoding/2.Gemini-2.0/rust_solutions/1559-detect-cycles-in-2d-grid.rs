impl Solution {
    pub fn contains_cycle(grid: Vec<Vec<char>>) -> bool {
        let m = grid.len();
        let n = grid[0].len();
        let mut visited = vec![vec![false; n]; m];

        fn dfs(
            grid: &Vec<Vec<char>>,
            visited: &mut Vec<Vec<bool>>,
            i: usize,
            j: usize,
            parent_i: i32,
            parent_j: i32,
        ) -> bool {
            visited[i][j] = true;

            let directions = [(0, 1), (0, -1), (1, 0), (-1, 0)];
            for (dx, dy) in directions {
                let new_i = i as i32 + dx;
                let new_j = j as i32 + dy;

                if new_i >= 0 && new_i < grid.len() as i32 && new_j >= 0 && new_j < grid[0].len() as i32 {
                    let new_i = new_i as usize;
                    let new_j = new_j as usize;

                    if grid[new_i][new_j] == grid[i][j] {
                        if (new_i as i32) == parent_i && (new_j as i32) == parent_j {
                            continue;
                        }

                        if visited[new_i][new_j] {
                            return true;
                        }

                        if dfs(grid, visited, new_i, new_j, i as i32, j as i32) {
                            return true;
                        }
                    }
                }
            }

            false
        }

        for i in 0..m {
            for j in 0..n {
                if !visited[i][j] {
                    if dfs(&grid, &mut visited, i, j, -1, -1) {
                        return true;
                    }
                }
            }
        }

        false
    }
}