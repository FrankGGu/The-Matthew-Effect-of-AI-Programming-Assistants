impl Solution {
    pub fn reconstruct_matrix(mut upper: i32, mut lower: i32, colsum: Vec<i32>) -> Vec<Vec<i32>> {
        let n = colsum.len();
        let mut result = vec![vec![0; n], vec![0; n]];

        let total_col_sum: i32 = colsum.iter().sum();
        if total_col_sum != upper + lower {
            return vec![];
        }

        for j in 0..n {
            if colsum[j] == 2 {
                result[0][j] = 1;
                result[1][j] = 1;
                upper -= 1;
                lower -= 1;
            }
        }

        if upper < 0 || lower < 0 {
            return vec![];
        }

        for j in 0..n {
            if colsum[j] == 1 {
                if upper > 0 {
                    result[0][j] = 1;
                    upper -= 1;
                } else {
                    result[1][j] = 1;
                    lower -= 1;
                }
            }
        }

        if upper == 0 && lower == 0 {
            result
        } else {
            vec![]
        }
    }
}