impl Solution {
    pub fn num_special(mat: Vec<Vec<i32>>) -> i32 {
        let m = mat.len();
        let n = mat[0].len();
        let mut row_sums = vec![0; m];
        let mut col_sums = vec![0; n];

        for i in 0..m {
            for j in 0..n {
                if mat[i][j] == 1 {
                    row_sums[i] += 1;
                    col_sums[j] += 1;
                }
            }
        }

        let mut count = 0;
        for i in 0..m {
            for j in 0..n {
                if mat[i][j] == 1 && row_sums[i] == 1 && col_sums[j] == 1 {
                    count += 1;
                }
            }
        }

        count
    }
}