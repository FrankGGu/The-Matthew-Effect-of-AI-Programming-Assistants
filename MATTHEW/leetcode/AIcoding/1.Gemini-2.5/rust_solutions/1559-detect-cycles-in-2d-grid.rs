struct Solution;

impl Solution {
    pub fn contains_cycle(grid: Vec<Vec<char>>) -> bool {
        let rows = grid.len();
        let cols = grid[0].len();
        // visited stores Option<i32> where Some(depth) means visited at that depth
        // and None means not visited.
        // It's effectively tracking "currently in recursion stack"
        let mut visited: Vec<Vec<Option<i32>>> = vec![vec![None; cols]; rows];

        for r in 0..rows {
            for c in 0..cols {
                // Only start DFS from a truly unvisited cell
                if visited[r][c].is_none() {
                    if Self::dfs(r as i32, c as i32, -1, -1, grid[r][c], &grid, &mut visited, 0) {
                        return true;
                    }
                }
            }
        }
        false
    }

    fn dfs(
        r: i32,
        c: i32,
        parent_r: i32,
        parent_c: i32,
        target_char: char,
        grid: &Vec<Vec<char>>,
        visited: &mut Vec<Vec<Option<i32>>>,
        current_depth: i32,
    ) -> bool {
        let rows = grid.len() as i32;
        let cols = grid[0].len() as i32;

        // Mark current cell as visited with its depth
        visited[r as usize][c as usize] = Some(current_depth);

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        for i in 0..4 {
            let nr = r + dr[i];
            let nc = c + dc[i];

            // Check bounds
            if nr < 0 || nr >= rows || nc < 0 || nc >= cols {
                continue;
            }

            // Check if it's the parent node (to avoid trivial back-and-forth)
            if nr == parent_r && nc == parent_c {
                continue;
            }

            // Check character match
            if grid[nr as usize][nc as usize] == target_char {
                if let Some(neighbor_depth) = visited[nr as usize][nc as usize] {
                    // Found a visited node (in the current path) that is not the parent
                    // This indicates a cycle. Calculate its length.
                    if current_depth - neighbor_depth + 1 >= 4 {
                        return true;
                    }
                    // If cycle length is less than 4, it's not a valid cycle
                    // according to the problem statement, so we don't return true.
                    // We continue exploring other paths from the current node.
                } else {
                    // Not visited, recurse
                    if Self::dfs(nr, nc, r, c, target_char, grid, visited, current_depth + 1) {
                        return true;
                    }
                }
            }
        }

        // Backtrack: mark current cell as unvisited (no longer in current path)
        visited[r as usize][c as usize] = None;
        false
    }
}