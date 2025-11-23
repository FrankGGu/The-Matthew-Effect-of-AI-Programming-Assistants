impl Solution {

use std::cmp::max;
use std::collections::HashMap;

impl Solution {
    pub fn longest_increasing_path(mut matrix: Vec<Vec<i32>>) -> i32 {
        if matrix.is_empty() || matrix[0].is_empty() {
            return 0;
        }

        let rows = matrix.len();
        let cols = matrix[0].len();
        let mut memo = HashMap::new();
        let mut result = 0;

        for i in 0..rows {
            for j in 0..cols {
                result = max(result, dfs(&mut matrix, i, j, &mut memo));
            }
        }

        result
    }
}

fn dfs(matrix: &mut Vec<Vec<i32>>, i: usize, j: usize, memo: &mut HashMap<(usize, usize), i32>) -> i32 {
    if let Some(&val) = memo.get(&(i, j)) {
        return val;
    }

    let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];
    let mut max_len = 1;

    for &(dx, dy) in &directions {
        let ni = i as i32 + dx;
        let nj = j as i32 + dy;
        if ni >= 0 && ni < matrix.len() as i32 && nj >= 0 && nj < matrix[0].len() as i32 {
            let ni = ni as usize;
            let nj = nj as usize;
            if matrix[ni][nj] > matrix[i][j] {
                max_len = max(max_len, 1 + dfs(matrix, ni, nj, memo));
            }
        }
    }

    memo.insert((i, j), max_len);
    max_len
}
}