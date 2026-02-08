impl Solution {
    pub fn reclaim_the_base(grid: Vec<Vec<i32>>) -> i32 {
        let mut count = 0;
        let directions = vec![(1, 0), (-1, 0), (0, 1), (0, -1)];
        let mut visited = vec![vec![false; grid[0].len()]; grid.len()];

        fn dfs(grid: &Vec<Vec<i32>>, visited: &mut Vec<Vec<bool>>, i: usize, j: usize) {
            visited[i][j] = true;
            for (dx, dy) in &[(1, 0), (-1, 0), (0, 1), (0, -1)] {
                let ni = (i as isize + dx) as usize;
                let nj = (j as isize + dy) as usize;
                if ni < grid.len() && nj < grid[0].len() && grid[ni][nj] == 1 && !visited[ni][nj] {
                    dfs(grid, visited, ni, nj);
                }
            }
        }

        for i in 0..grid.len() {
            for j in 0..grid[0].len() {
                if grid[i][j] == 1 && !visited[i][j] {
                    dfs(&grid, &mut visited, i, j);
                    count += 1;
                }
            }
        }

        count
    }
}