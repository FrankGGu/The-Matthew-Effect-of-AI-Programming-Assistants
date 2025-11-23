impl Solution {
    pub fn color_border(grid: Vec<Vec<i32>>, row: i32, col: i32, color: i32) -> Vec<Vec<i32>> {
        let mut grid = grid.clone();
        let original_color = grid[row as usize][col as usize];
        let mut visited = vec![vec![false; grid[0].len()]; grid.len()];
        let directions = vec![(0, 1), (1, 0), (0, -1), (-1, 0)];
        let mut border_cells = Vec::new();

        fn is_border(grid: &Vec<Vec<i32>>, x: usize, y: usize, original_color: i32) -> bool {
            let directions = vec![(0, 1), (1, 0), (0, -1), (-1, 0)];
            for (dx, dy) in directions.iter() {
                let nx = x as isize + dx;
                let ny = y as isize + dy;
                if nx < 0 || ny < 0 || nx >= grid.len() as isize || ny >= grid[0].len() as isize || grid[nx as usize][ny as usize] != original_color {
                    return true;
                }
            }
            false
        }

        fn dfs(grid: &mut Vec<Vec<i32>>, x: usize, y: usize, original_color: i32, visited: &mut Vec<Vec<bool>>, border_cells: &mut Vec<(usize, usize)>) {
            visited[x][y] = true;
            if is_border(grid, x, y, original_color) {
                border_cells.push((x, y));
            }
            let directions = vec![(0, 1), (1, 0), (0, -1), (-1, 0)];
            for (dx, dy) in directions.iter() {
                let nx = x as isize + dx;
                let ny = y as isize + dy;
                if nx >= 0 && ny >= 0 && nx < grid.len() as isize && ny < grid[0].len() as isize && !visited[nx as usize][ny as usize] && grid[nx as usize][ny as usize] == original_color {
                    dfs(grid, nx as usize, ny as usize, original_color, visited, border_cells);
                }
            }
        }

        dfs(&mut grid, row as usize, col as usize, original_color, &mut visited, &mut border_cells);

        for (x, y) in border_cells {
            grid[x][y] = color;
        }

        grid
    }
}