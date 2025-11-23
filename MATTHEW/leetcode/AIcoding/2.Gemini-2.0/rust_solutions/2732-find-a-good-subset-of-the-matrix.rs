impl Solution {
    pub fn good_subsetof_binary_matrix(matrix: Vec<Vec<i32>>) -> Vec<i32> {
        let m = matrix.len();
        let n = matrix[0].len();

        for i in 0..m {
            let mut all_zeros = true;
            for j in 0..n {
                if matrix[i][j] == 1 {
                    all_zeros = false;
                    break;
                }
            }
            if all_zeros {
                return vec![i as i32];
            }
        }

        for i in 0..m {
            for j in (i + 1)..m {
                let mut good = true;
                for k in 0..n {
                    if matrix[i][k] == 1 && matrix[j][k] == 1 {
                        good = false;
                        break;
                    }
                }
                if good {
                    return vec![i as i32, j as i32];
                }
            }
        }

        vec![]
    }
}