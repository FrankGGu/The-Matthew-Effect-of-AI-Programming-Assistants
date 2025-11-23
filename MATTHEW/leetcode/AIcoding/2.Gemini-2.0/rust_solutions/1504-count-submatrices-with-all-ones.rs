impl Solution {
    pub fn num_submat(mat: Vec<Vec<i32>>) -> i32 {
        let m = mat.len();
        let n = mat[0].len();
        let mut height = vec![vec![0; n]; m];
        for i in 0..m {
            for j in 0..n {
                if mat[i][j] == 1 {
                    height[i][j] = if i > 0 { height[i - 1][j] + 1 } else { 1 };
                }
            }
        }

        let mut ans = 0;
        for i in 0..m {
            for j in 0..n {
                let mut min_height = height[i][j];
                for k in (0..=j).rev() {
                    min_height = min_height.min(height[i][k]);
                    ans += min_height;
                }
            }
        }
        ans
    }
}