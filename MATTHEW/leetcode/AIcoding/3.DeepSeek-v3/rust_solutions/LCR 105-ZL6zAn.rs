impl Solution {
    pub fn max_area_of_island(grid: Vec<Vec<i32>>) -> i32 {
        let mut max_area = 0;
        let mut visited = vec![vec![false; grid[0].len()]; grid.len()];

        for i in 0..grid.len() {
            for j in 0..grid[0].len() {
                if grid[i][j] == 1 && !visited[i][j] {
                    let area = Self::dfs(&grid, &mut visited, i, j);
                    max_area = max_area.max(area);
                }
            }
        }

        max_area
    }

    fn dfs(grid: &Vec<Vec<i32>>, visited: &mut Vec<Vec<bool>>, i: usize, j: usize) -> i32 {
        if i >= grid.len() || j >= grid[0].len() || grid[i][j] == 0 || visited[i][j] {
            return 0;
        }

        visited[i][j] = true;
        let mut area = 1;

        if i > 0 {
            area += Self::dfs(grid, visited, i - 1, j);
        }
        if j > 0 {
            area += Self::dfs(grid, visited, i, j - 1);
        }
        if i + 1 < grid.len() {
            area += Self::dfs(grid, visited, i + 1, j);
        }
        if j + 1 < grid[0].len() {
            area += Self::dfs(grid, visited, i, j + 1);
        }

        area
    }
}