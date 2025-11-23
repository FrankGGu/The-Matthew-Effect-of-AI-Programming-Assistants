impl Solution {
    pub fn largest_submatrix(matrix: Vec<Vec<i32>>) -> i32 {
        let m = matrix.len();
        let n = matrix[0].len();
        let mut heights = vec![0; n];
        let mut max_area = 0;

        for i in 0..m {
            for j in 0..n {
                heights[j] = if matrix[i][j] == 1 { heights[j] + 1 } else { 0 };
            }
            let mut sorted_heights = heights.clone();
            sorted_heights.sort_unstable();
            for j in 0..n {
                max_area = max_area.max(sorted_heights[j] * (j + 1) as i32);
            }
        }
        max_area
    }
}