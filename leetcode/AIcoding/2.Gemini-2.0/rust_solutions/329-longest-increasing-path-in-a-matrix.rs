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
                max_len = max_len.max(Self::dfs(&matrix, i as i32, j as i32, &mut dp));
            }
        }

        max_len
    }

    fn dfs(matrix: &Vec<Vec<i32>>, i: i32, j: i32, dp: &mut Vec<Vec<i32>>) -> i32 {
        let m = matrix.len() as i32;
        let n = matrix[0].len() as i32;

        if dp[i as usize][j as usize] != 0 {
            return dp[i as usize][j as usize];
        }

        let mut max_len = 1;
        let directions: [(i32, i32); 4] = [(0, 1), (0, -1), (1, 0), (-1, 0)];

        for &(dx, dy) in &directions {
            let new_i = i + dx;
            let new_j = j + dy;

            if new_i >= 0 && new_i < m && new_j >= 0 && new_j < n && matrix[new_i as usize][new_j as usize] > matrix[i as usize][j as usize] {
                max_len = max_len.max(1 + Self::dfs(matrix, new_i, new_j, dp));
            }
        }

        dp[i as usize][j as usize] = max_len;
        max_len
    }
}