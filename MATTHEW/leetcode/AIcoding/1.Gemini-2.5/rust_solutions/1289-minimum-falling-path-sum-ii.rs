impl Solution {
    pub fn min_falling_path_sum_ii(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        if n == 0 {
            return 0;
        }
        if n == 1 {
            return grid[0][0];
        }

        let mut prev_dp = grid[0].clone();

        for i in 1..n {
            let mut min1 = i32::MAX;
            let mut idx1 = -1;
            let mut min2 = i32::MAX;

            for (j, &val) in prev_dp.iter().enumerate() {
                if val < min1 {
                    min2 = min1;
                    min1 = val;
                    idx1 = j as i32;
                } else if val < min2 {
                    min2 = val;
                }
            }

            let mut curr_dp = vec![0; n];
            for j in 0..n {
                if (j as i32) == idx1 {
                    curr_dp[j] = grid[i][j] + min2;
                } else {
                    curr_dp[j] = grid[i][j] + min1;
                }
            }
            prev_dp = curr_dp;
        }

        *prev_dp.iter().min().unwrap()
    }
}