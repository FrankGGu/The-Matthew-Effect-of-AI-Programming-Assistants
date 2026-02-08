impl Solution {
    pub fn longest_increasing_path(matrix: Vec<Vec<i32>>) -> i32 {
        if matrix.is_empty() || matrix[0].is_empty() {
            return 0;
        }
        let m = matrix.len();
        let n = matrix[0].len();
        let mut cache = vec![vec![0; n]; m];
        let mut max_len = 0;
        for i in 0..m {
            for j in 0..n {
                max_len = max_len.max(Self::dfs(&matrix, i, j, &mut cache));
            }
        }
        max_len
    }

    fn dfs(matrix: &Vec<Vec<i32>>, i: usize, j: usize, cache: &mut Vec<Vec<i32>>) -> i32 {
        if cache[i][j] != 0 {
            return cache[i][j];
        }
        let dirs = [(-1, 0), (1, 0), (0, -1), (0, 1)];
        let m = matrix.len() as i32;
        let n = matrix[0].len() as i32;
        let mut max = 1;
        for &(di, dj) in dirs.iter() {
            let ni = i as i32 + di;
            let nj = j as i32 + dj;
            if ni >= 0 && ni < m && nj >= 0 && nj < n {
                let ni = ni as usize;
                let nj = nj as usize;
                if matrix[ni][nj] > matrix[i][j] {
                    max = max.max(1 + Self::dfs(matrix, ni, nj, cache));
                }
            }
        }
        cache[i][j] = max;
        max
    }
}