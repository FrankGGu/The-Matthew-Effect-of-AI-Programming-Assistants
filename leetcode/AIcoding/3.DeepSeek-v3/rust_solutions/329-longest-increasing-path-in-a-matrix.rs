impl Solution {
    pub fn longest_increasing_path(matrix: Vec<Vec<i32>>) -> i32 {
        if matrix.is_empty() || matrix[0].is_empty() {
            return 0;
        }
        let rows = matrix.len();
        let cols = matrix[0].len();
        let mut cache = vec![vec![0; cols]; rows];
        let mut max_len = 0;

        for i in 0..rows {
            for j in 0..cols {
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
        let rows = matrix.len();
        let cols = matrix[0].len();
        let mut max = 1;

        for (dx, dy) in dirs.iter() {
            let x = i as i32 + dx;
            let y = j as i32 + dy;
            if x >= 0 && x < rows as i32 && y >= 0 && y < cols as i32 {
                let x = x as usize;
                let y = y as usize;
                if matrix[x][y] > matrix[i][j] {
                    max = max.max(Self::dfs(matrix, x, y, cache) + 1);
                }
            }
        }
        cache[i][j] = max;
        max
    }
}