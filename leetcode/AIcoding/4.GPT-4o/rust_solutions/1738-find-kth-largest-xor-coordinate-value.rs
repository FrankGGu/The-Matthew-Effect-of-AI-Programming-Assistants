impl Solution {
    pub fn kth_largest_value(matrix: Vec<Vec<i32>>, k: i32) -> i32 {
        let n = matrix.len();
        let m = matrix[0].len();
        let mut xor_matrix = vec![vec![0; m]; n];

        for i in 0..n {
            for j in 0..m {
                xor_matrix[i][j] = matrix[i][j] 
                    ^ if i > 0 { xor_matrix[i - 1][j] } else { 0 } 
                    ^ if j > 0 { xor_matrix[i][j - 1] } else { 0 } 
                    ^ if i > 0 && j > 0 { xor_matrix[i - 1][j - 1] } else { 0 };
            }
        }

        let mut values = xor_matrix.iter().flat_map(|row| row.iter()).collect::<Vec<_>>();
        values.sort_unstable();
        *values[values.len() - k as usize]
    }
}