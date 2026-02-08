impl Solution {
    pub fn unique_paths_iii(grid: Vec<Vec<i32>>) -> i32 {
        let mut grid = grid;
        let (mut start_x, mut start_y) = (0, 0);
        let mut empty = 0;
        let rows = grid.len();
        let cols = grid[0].len();

        for i in 0..rows {
            for j in 0..cols {
                match grid[i][j] {
                    1 => {
                        start_x = i;
                        start_y = j;
                    }
                    0 => empty += 1,
                    _ => (),
                }
            }
        }

        let mut count = 0;
        Self::dfs(&mut grid, start_x, start_y, empty + 1, &mut count);
        count
    }

    fn dfs(grid: &mut Vec<Vec<i32>>, x: usize, y: usize, remain: i32, count: &mut i32) {
        if grid[x][y] == 2 {
            if remain == 0 {
                *count += 1;
            }
            return;
        }

        let temp = grid[x][y];
        grid[x][y] = -1;
        let dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)];
        let rows = grid.len() as i32;
        let cols = grid[0].len() as i32;

        for (dx, dy) in dirs.iter() {
            let nx = x as i32 + dx;
            let ny = y as i32 + dy;
            if nx >= 0 && nx < rows && ny >= 0 && ny < cols {
                let nx = nx as usize;
                let ny = ny as usize;
                if grid[nx][ny] != -1 {
                    Self::dfs(grid, nx, ny, remain - 1, count);
                }
            }
        }

        grid[x][y] = temp;
    }
}