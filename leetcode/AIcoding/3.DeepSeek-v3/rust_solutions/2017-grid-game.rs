impl Solution {
    pub fn grid_game(grid: Vec<Vec<i32>>) -> i64 {
        let n = grid[0].len();
        let mut prefix1 = vec![0; n + 1];
        let mut prefix2 = vec![0; n + 1];

        for i in 0..n {
            prefix1[i + 1] = prefix1[i] + grid[0][i] as i64;
            prefix2[i + 1] = prefix2[i] + grid[1][i] as i64;
        }

        let mut res = i64::MAX;
        for i in 0..n {
            let option1 = prefix1[n] - prefix1[i + 1];
            let option2 = prefix2[i];
            let max_option = std::cmp::max(option1, option2);
            res = std::cmp::min(res, max_option);
        }

        res
    }
}