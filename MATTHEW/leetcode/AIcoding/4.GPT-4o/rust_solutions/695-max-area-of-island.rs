impl Solution {
    pub fn max_area_of_island(grid: Vec<Vec<i32>>) -> i32 {
        let mut max_area = 0;
        let mut visited = vec![vec![false; grid[0].len()]; grid.len()];

        fn dfs(grid: &Vec<Vec<i32>>, visited: &mut Vec<Vec<bool>>, x: isize, y: isize) -> i32 {
            if x < 0 || y < 0 || x >= grid.len() as isize || y >= grid[0].len() as isize || visited[x as usize][y as usize] || grid[x as usize][y as usize] == 0 {
                return 0;
            }
            visited[x as usize][y as usize] = true;
            1 + dfs(grid, visited, x + 1, y) + dfs(grid, visited, x - 1, y) + dfs(grid, visited, x, y + 1) + dfs(grid, visited, x, y - 1)
        }

        for i in 0..grid.len() {
            for j in 0..grid[0].len() {
                if grid[i][j] == 1 && !visited[i][j] {
                    let area = dfs(&grid, &mut visited, i as isize, j as isize);
                    max_area = max_area.max(area);
                }
            }
        }
        max_area
    }
}