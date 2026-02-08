impl Solution {
    pub fn num_submatrix_sum_target(matrix: Vec<Vec<i32>>, target: i32) -> i32 {
        let m = matrix.len();
        let n = matrix[0].len();
        let mut count = 0;

        for i in 0..m {
            for j in 1..n {
                matrix[i][j] += matrix[i][j - 1];
            }
        }

        for c1 in 0..n {
            for c2 in c1..n {
                let mut map = std::collections::HashMap::new();
                map.insert(0, 1);
                let mut sum = 0;
                for r in 0..m {
                    let submatrix_sum = if c1 > 0 {
                        matrix[r][c2] - matrix[r][c1 - 1]
                    } else {
                        matrix[r][c2]
                    };
                    sum += submatrix_sum;
                    if let Some(&val) = map.get(&(sum - target)) {
                        count += val;
                    }
                    *map.entry(sum).or_insert(0) += 1;
                }
            }
        }

        count
    }
}