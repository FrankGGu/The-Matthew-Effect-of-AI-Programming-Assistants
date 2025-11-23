impl Solution {
    pub fn get_maximum_gold(grid: Vec<Vec<i32>>) -> i32 {
        let mut max_gold = 0;
        let rows = grid.len();
        if rows == 0 {
            return 0;
        }
        let cols = grid[0].len();
        let mut visited = vec![vec![false; cols]; rows];

        for i in 0..rows {
            for j in 0..cols {
                if grid[i][j] != 0 {
                    let current = Self::dfs(&grid, i, j, &mut visited);
                    max_gold = max_gold.max(current);
                }
            }
        }

        max_gold
    }

    fn dfs(grid: &Vec<Vec<i32>>, i: usize, j: usize, visited: &mut Vec<Vec<bool>>) -> i32 {
        if i >= grid.len() || j >= grid[0].len() || grid[i][j] == 0 || visited[i][j] {
            return 0;
        }

        visited[i][j] = true;
        let mut current_max = 0;
        let directions = vec![(-1, 0), (1, 0), (0, -1), (0, 1)];

        for (dx, dy) in directions {
            let x = i as i32 + dx;
            let y = j as i32 + dy;
            if x >= 0 && y >= 0 {
                current_max = current_max.max(Self::dfs(grid, x as usize, y as usize, visited));
            }
        }

        visited[i][j] = false;
        current_max + grid[i][j]
    }
}