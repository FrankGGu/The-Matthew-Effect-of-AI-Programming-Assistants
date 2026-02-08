use std::collections::VecDeque;

impl Solution {
    pub fn shortest_bridge(mut grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        let mut island_cells: VecDeque<(i32, i32)> = VecDeque::new();
        let mut found_first_island = false;

        for r in 0..m {
            for c in 0..n {
                if grid[r][c] == 1 {
                    Self::dfs(r as i32, c as i32, m as i32, n as i32, &mut grid, &mut island_cells);
                    found_first_island = true;
                    break;
                }
            }
            if found_first_island {
                break;
            }
        }

        let mut distance = 0;
        while !island_cells.is_empty() {
            let level_size = island_cells.len();
            for _ in 0..level_size {
                let (r, c) = island_cells.pop_front().unwrap();

                for dir in &directions {
                    let nr = r + dir.0;
                    let nc = c + dir.1;

                    if nr >= 0 && nr < m as i32 && nc >= 0 && nc < n as i32 {
                        match grid[nr as usize][nc as usize] {
                            1 => return distance, // Found the second island
                            0 => { // Water cell, expand to it
                                grid[nr as usize][nc as usize] = 2; // Mark as visited
                                island_cells.push_back((nr, nc));
                            }
                            _ => {} // Already visited (part of first island or expanded water), do nothing
                        }
                    }
                }
            }
            distance += 1;
        }

        -1 // Should not be reached given problem constraints (always two islands)
    }

    fn dfs(r: i32, c: i32, m: i32, n: i32, grid: &mut Vec<Vec<i32>>, island_cells: &mut VecDeque<(i32, i32)>) {
        if r < 0 || r >= m || c < 0 || c >= n || grid[r as usize][c as usize] != 1 {
            return;
        }

        grid[r as usize][c as usize] = 2; // Mark as visited (part of first island)
        island_cells.push_back((r, c)); // Add to BFS queue

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];
        for dir in &directions {
            Self::dfs(r + dir.0, c + dir.1, m, n, grid, island_cells);
        }
    }
}