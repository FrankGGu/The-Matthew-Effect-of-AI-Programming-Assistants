impl Solution {
    pub fn grid_game(grid: Vec<Vec<i32>>) -> i64 {
        let n = grid[0].len();
        let mut suffix_sum_row0: Vec<i64> = vec![0; n + 1];
        let mut prefix_sum_row1: Vec<i64> = vec![0; n + 1];

        for i in (0..n).rev() {
            suffix_sum_row0[i] = suffix_sum_row0[i + 1] + grid[0][i] as i64;
        }

        for i in 0..n {
            prefix_sum_row1[i + 1] = prefix_sum_row1[i] + grid[1][i] as i64;
        }

        let mut ans: i64 = i64::MAX;

        for i in 0..n {
            ans = ans.min(suffix_sum_row0[i + 1].max(prefix_sum_row1[i]));
        }

        ans
    }
}