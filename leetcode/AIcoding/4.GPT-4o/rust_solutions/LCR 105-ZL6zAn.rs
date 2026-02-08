pub struct Solution;

impl Solution {
    pub fn max_area_of_island(grid: Vec<Vec<i32>>) -> i32 {
        let mut visited = vec![vec![false; grid[0].len()]; grid.len()];
        let directions = vec![(1, 0), (-1, 0), (0, 1), (0, -1)];

        fn dfs(grid: &Vec<Vec<i32>>, visited: &mut Vec<Vec<bool>>, i: isize, j: isize) -> i32 {
            if i < 0 || j < 0 || i >= grid.len() as isize || j >= grid[0].len() as isize || grid[i as usize][j as usize] == 0 || visited[i as usize][j as usize] {
                return 0;
            }
            visited[i as usize][j as usize] = true;
            let mut area = 1;
            for &(dx, dy) in &directions {
                area += dfs(grid, visited, i + dx, j + dy);
            }
            area
        }

        let mut max_area = 0;
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