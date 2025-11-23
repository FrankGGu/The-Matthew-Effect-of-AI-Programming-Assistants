impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn max_increasing_cells(mut matrix: Vec<Vec<i32>>) -> i32 {
        let m = matrix.len();
        let n = matrix[0].len();
        let mut cell_value = HashMap::new();

        for i in 0..m {
            for j in 0..n {
                cell_value.insert((i, j), matrix[i][j]);
            }
        }

        let mut sorted_cells: Vec<(i32, usize, usize)> = Vec::new();
        for i in 0..m {
            for j in 0..n {
                sorted_cells.push((matrix[i][j], i, j));
            }
        }

        sorted_cells.sort();

        let mut dp = vec![vec![0; n]; m];
        let mut queue = VecDeque::new();

        for (val, i, j) in &sorted_cells {
            if *val == 0 {
                dp[*i][*j] = 1;
                queue.push_back((*i, *j));
            }
        }

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        while let Some((i, j)) = queue.pop_front() {
            for &(di, dj) in &directions {
                let ni = i as i32 + di;
                let nj = j as i32 + dj;
                if ni >= 0 && ni < m as i32 && nj >= 0 && nj < n as i32 {
                    let ni = ni as usize;
                    let nj = nj as usize;
                    if cell_value[&(ni, nj)] > cell_value[&(i, j)] {
                        if dp[ni][nj] < dp[i][j] + 1 {
                            dp[ni][nj] = dp[i][j] + 1;
                            queue.push_back((ni, nj));
                        }
                    }
                }
            }
        }

        let mut max_val = 0;
        for i in 0..m {
            for j in 0..n {
                max_val = max_val.max(dp[i][j]);
            }
        }

        max_val
    }
}
}