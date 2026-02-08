use std::collections::VecDeque;

impl Solution {
    pub fn max_fish(mut grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut max_fish_count = 0;

        let directions = vec![(-1, 0), (1, 0), (0, -1), (0, 1)];

        for r in 0..m {
            for c in 0..n {
                if grid[r][c] > 0 {
                    let mut current_fish_count = 0;
                    let mut stack = Vec::new(); 

                    // Add the starting cell's fish and mark it as visited
                    current_fish_count += grid[r][c];
                    grid[r][c] = 0;
                    stack.push((r, c));

                    while let Some((row, col)) = stack.pop() {
                        for (dr, dc) in &directions {
                            let nr = row as isize + dr;
                            let nc = col as isize + dc;

                            if nr >= 0 && nr < m as isize && nc >= 0 && nc < n as isize {
                                let nr = nr as usize;
                                let nc = nc as usize;
                                if grid[nr][nc] > 0 {
                                    current_fish_count += grid[nr][nc];
                                    grid[nr][nc] = 0; 
                                    stack.push((nr, nc));
                                }
                            }
                        }
                    }
                    max_fish_count = max_fish_count.max(current_fish_count);
                }
            }
        }
        max_fish_count
    }
}