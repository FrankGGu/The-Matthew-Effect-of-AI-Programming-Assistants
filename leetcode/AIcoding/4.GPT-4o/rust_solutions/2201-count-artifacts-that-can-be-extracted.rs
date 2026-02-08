pub fn count_artifacts(grid: Vec<Vec<i32>>) -> i32 {
    let mut visited = vec![vec![false; grid[0].len()]; grid.len()];
    let mut count = 0;

    fn dfs(grid: &Vec<Vec<i32>>, i: usize, j: usize, visited: &mut Vec<Vec<bool>>) {
        if i >= grid.len() || j >= grid[0].len() || visited[i][j] || grid[i][j] == 0 {
            return;
        }
        visited[i][j] = true;
        dfs(grid, i.wrapping_sub(1), j, visited);
        dfs(grid, i + 1, j, visited);
        dfs(grid, i, j.wrapping_sub(1), visited);
        dfs(grid, i, j + 1, visited);
    }

    for i in 0..grid.len() {
        for j in 0..grid[0].len() {
            if grid[i][j] == 1 && !visited[i][j] {
                count += 1;
                dfs(&grid, i, j, &mut visited);
            }
        }
    }

    count
}