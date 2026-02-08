impl Solution {
    pub fn longest_increasing_path(matrix: Vec<Vec<i32>>) -> i32 {
        let m = matrix.len();
        let n = if m > 0 { matrix[0].len() } else { 0 };
        if m == 0 || n == 0 {
            return 0;
        }

        let mut dp = vec![vec![0; n]; m];
        let mut max_len = 0;

        for i in 0..m {
            for j in 0..n {
                max_len = max_len.max(Solution::dfs(&matrix, i, j, &mut dp));
            }
        }

        max_len
    }

    fn dfs(matrix: &Vec<Vec<i32>>, i: usize, j: usize, dp: &mut Vec<Vec<i32>>) -> i32 {
        if dp[i][j] != 0 {
            return dp[i][j];
        }

        let m = matrix.len();
        let n = matrix[0].len();
        let mut max_len = 1;

        let directions: [(i32, i32); 4] = [(0, 1), (0, -1), (1, 0), (-1, 0)];

        for (dx, dy) in directions {
            let new_i = i as i32 + dx;
            let new_j = j as i32 + dy;

            if new_i >= 0 && new_i < m as i32 && new_j >= 0 && new_j < n as i32 {
                let new_i = new_i as usize;
                let new_j = new_j as usize;

                if matrix[new_i][new_j] > matrix[i][j] {
                    max_len = max_len.max(1 + Solution::dfs(matrix, new_i, new_j, dp));
                }
            }
        }

        dp[i][j] = max_len;
        max_len
    }
}