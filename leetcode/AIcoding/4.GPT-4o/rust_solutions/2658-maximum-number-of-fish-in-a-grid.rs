impl Solution {
    pub fn num_fish(grid: Vec<Vec<i32>>) -> i32 {
        let mut max_fish = 0;
        let rows = grid.len();
        let cols = grid[0].len();
        let directions = vec![(1, 0), (0, 1), (-1, 0), (0, -1)];

        for r in 0..rows {
            for c in 0..cols {
                if grid[r][c] > 0 {
                    let mut fish_count = 0;
                    let mut stack = vec![(r, c)];
                    while let Some((x, y)) = stack.pop() {
                        if grid[x][y] > 0 {
                            fish_count += grid[x][y];
                            grid[x][y] = 0;
                            for &(dx, dy) in &directions {
                                let nx = (x as isize + dx) as usize;
                                let ny = (y as isize + dy) as usize;
                                if nx < rows && ny < cols && grid[nx][ny] > 0 {
                                    stack.push((nx, ny));
                                }
                            }
                        }
                    }
                    max_fish = max_fish.max(fish_count);
                }
            }
        }
        max_fish
    }
}