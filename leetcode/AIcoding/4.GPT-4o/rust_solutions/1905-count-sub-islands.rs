impl Solution {
    pub fn count_sub_islands(grid1: Vec<Vec<i32>>, grid2: Vec<Vec<i32>>) -> i32 {
        let (m, n) = (grid1.len(), grid1[0].len());
        let mut grid2 = grid2.clone();

        fn dfs(grid: &mut Vec<Vec<i32>>, i: usize, j: usize, m: usize, n: usize) -> bool {
            if i >= m || j >= n || grid[i][j] == 0 {
                return true;
            }
            grid[i][j] = 0;
            let mut is_sub_island = grid1[i][j] == 1;
            for (di, dj) in [(1, 0), (-1, 0), (0, 1), (0, -1)] {
                let (ni, nj) = (i as isize + di, j as isize + dj);
                if ni >= 0 && nj >= 0 && ni < m as isize && nj < n as isize {
                    is_sub_island &= dfs(grid, ni as usize, nj as usize, m, n);
                }
            }
            is_sub_island
        }

        let mut result = 0;
        for i in 0..m {
            for j in 0..n {
                if grid2[i][j] == 1 {
                    if dfs(&mut grid2, i, j, m, n) {
                        result += 1;
                    }
                }
            }
        }
        result
    }
}