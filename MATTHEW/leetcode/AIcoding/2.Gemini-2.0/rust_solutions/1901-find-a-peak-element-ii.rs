impl Solution {
    pub fn find_peak_grid(mat: Vec<Vec<i32>>) -> Vec<i32> {
        let (m, n) = (mat.len(), mat[0].len());
        let (mut low, mut high) = (0, n - 1);

        while low <= high {
            let mid = low + (high - low) / 2;
            let mut max_row = 0;
            for i in 1..m {
                if mat[i][mid] > mat[max_row][mid] {
                    max_row = i;
                }
            }

            if mid > 0 && mat[max_row][mid - 1] > mat[max_row][mid] {
                high = mid - 1;
            } else if mid < n - 1 && mat[max_row][mid + 1] > mat[max_row][mid] {
                low = mid + 1;
            } else {
                return vec![max_row as i32, mid as i32];
            }
        }

        vec![]
    }
}