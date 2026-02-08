impl Solution {
    pub fn num_special(mat: Vec<Vec<i32>>) -> i32 {
        let m = mat.len();
        if m == 0 {
            return 0;
        }
        let n = mat[0].len();
        if n == 0 {
            return 0;
        }

        let mut row_counts = vec![0; m];
        let mut col_counts = vec![0; n];

        for i in 0..m {
            for j in 0..n {
                if mat[i][j] == 1 {
                    row_counts[i] += 1;
                    col_counts[j] += 1;
                }
            }
        }

        let mut special_positions = 0;
        for i in 0..m {
            for j in 0..n {
                if mat[i][j] == 1 && row_counts[i] == 1 && col_counts[j] == 1 {
                    special_positions += 1;
                }
            }
        }

        special_positions
    }
}