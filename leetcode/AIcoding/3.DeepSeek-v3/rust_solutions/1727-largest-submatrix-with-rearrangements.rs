impl Solution {
    pub fn largest_submatrix(matrix: Vec<Vec<i32>>) -> i32 {
        let m = matrix.len();
        let n = matrix[0].len();
        let mut heights = vec![0; n];
        let mut res = 0;

        for i in 0..m {
            for j in 0..n {
                if matrix[i][j] == 1 {
                    heights[j] += 1;
                } else {
                    heights[j] = 0;
                }
            }

            let mut sorted_heights = heights.clone();
            sorted_heights.sort_unstable();

            for k in 0..n {
                res = res.max(sorted_heights[k] * (n - k) as i32);
            }
        }

        res
    }
}