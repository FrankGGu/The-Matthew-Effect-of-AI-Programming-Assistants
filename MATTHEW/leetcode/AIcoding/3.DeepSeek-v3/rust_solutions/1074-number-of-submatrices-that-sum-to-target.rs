use std::collections::HashMap;

impl Solution {
    pub fn num_submatrix_sum_target(matrix: Vec<Vec<i32>>, target: i32) -> i32 {
        let m = matrix.len();
        let n = matrix[0].len();
        let mut prefix = vec![vec![0; n + 1]; m + 1];

        for i in 1..=m {
            for j in 1..=n {
                prefix[i][j] = prefix[i - 1][j] + prefix[i][j - 1] - prefix[i - 1][j - 1] + matrix[i - 1][j - 1];
            }
        }

        let mut res = 0;
        for i1 in 1..=m {
            for i2 in i1..=m {
                let mut map = HashMap::new();
                map.insert(0, 1);
                for j in 1..=n {
                    let sum = prefix[i2][j] - prefix[i1 - 1][j];
                    res += map.get(&(sum - target)).unwrap_or(&0);
                    *map.entry(sum).or_insert(0) += 1;
                }
            }
        }
        res
    }
}