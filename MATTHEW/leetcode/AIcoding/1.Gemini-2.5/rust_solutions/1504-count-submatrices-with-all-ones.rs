impl Solution {
    pub fn num_submat(mat: Vec<Vec<i32>>) -> i32 {
        let m = mat.len();
        if m == 0 {
            return 0;
        }
        let n = mat[0].len();
        if n == 0 {
            return 0;
        }

        let mut total_submatrices = 0;
        let mut heights = vec![0; n];

        for i in 0..m {
            for j in 0..n {
                if mat[i][j] == 1 {
                    heights[j] += 1;
                } else {
                    heights[j] = 0;
                }
            }

            for j in 0..n {
                let mut min_h = heights[j];
                for k in (0..=j).rev() {
                    min_h = min_h.min(heights[k]);
                    total_submatrices += min_h;
                }
            }
        }

        total_submatrices
    }
}