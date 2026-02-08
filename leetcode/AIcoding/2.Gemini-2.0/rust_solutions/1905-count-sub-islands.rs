impl Solution {
    pub fn count_sub_islands(grid1: Vec<Vec<i32>>, grid2: Vec<Vec<i32>>) -> i32 {
        let m = grid1.len();
        let n = grid1[0].len();
        let mut grid2 = grid2;
        let mut count = 0;

        for i in 0..m {
            for j in 0..n {
                if grid2[i][j] == 1 {
                    if Self::is_sub_island(&mut grid2, &grid1, i, j, m, n) {
                        count += 1;
                    }
                }
            }
        }

        count
    }

    fn is_sub_island(grid2: &mut Vec<Vec<i32>>, grid1: &Vec<Vec<i32>>, i: usize, j: usize, m: usize, n: usize) -> bool {
        if i < 0 || i >= m || j < 0 || j >= n || grid2[i][j] == 0 {
            return true;
        }

        grid2[i][j] = 0;
        let mut result = grid1[i][j] == 1;

        result &= Self::is_sub_island(grid2, grid1, i + 1, j, m, n);
        result &= Self::is_sub_island(grid2, grid1, i - 1, j, m, n);
        result &= Self::is_sub_island(grid2, grid1, i, j + 1, m, n);
        result &= Self::is_sub_island(grid2, grid1, i, j - 1, m, n);

        result
    }
}