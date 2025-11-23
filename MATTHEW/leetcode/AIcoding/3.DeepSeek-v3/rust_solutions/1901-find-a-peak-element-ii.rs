impl Solution {
    pub fn find_peak_grid(mat: Vec<Vec<i32>>) -> Vec<i32> {
        let (mut left, mut right) = (0, mat.len() - 1);
        while left < right {
            let mid = left + (right - left) / 2;
            let max_col = Self::find_max_in_row(&mat[mid]);
            if mat[mid][max_col] < mat[mid + 1][max_col] {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        let max_col = Self::find_max_in_row(&mat[left]);
        vec![left as i32, max_col as i32]
    }

    fn find_max_in_row(row: &[i32]) -> usize {
        let mut max_col = 0;
        for i in 1..row.len() {
            if row[i] > row[max_col] {
                max_col = i;
            }
        }
        max_col
    }
}