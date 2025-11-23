impl Solution {
    pub fn find_max_fish(grid: Vec<Vec<i32>>) -> i32 {
        let mut max_fish = 0;
        let mut visited = vec![vec![false; grid[0].len()]; grid.len()];

        for i in 0..grid.len() {
            for j in 0..grid[0].len() {
                if grid[i][j] > 0 && !visited[i][j] {
                    let current = Self::dfs(&grid, &mut visited, i, j);
                    max_fish = max_fish.max(current);
                }
            }
        }

        max_fish
    }

    fn dfs(grid: &Vec<Vec<i32>>, visited: &mut Vec<Vec<bool>>, i: usize, j: usize) -> i32 {
        if i >= grid.len() || j >= grid[0].len() || grid[i][j] == 0 || visited[i][j] {
            return 0;
        }

        visited[i][j] = true;
        let mut sum = grid[i][j];

        if i > 0 {
            sum += Self::dfs(grid, visited, i - 1, j);
        }
        if j > 0 {
            sum += Self::dfs(grid, visited, i, j - 1);
        }
        if i + 1 < grid.len() {
            sum += Self::dfs(grid, visited, i + 1, j);
        }
        if j + 1 < grid[0].len() {
            sum += Self::dfs(grid, visited, i, j + 1);
        }

        sum
    }
}