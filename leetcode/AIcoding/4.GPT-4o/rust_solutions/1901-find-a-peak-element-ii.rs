pub fn find_peak_grid(mat: Vec<Vec<i32>>) -> Vec<i32> {
    let (m, n) = (mat.len(), mat[0].len());
    let mut left = 0;
    let mut right = n - 1;

    while left < right {
        let mid = (left + right) / 2;
        let mut max_row = 0;

        for i in 0..m {
            if mat[i][mid] > mat[max_row][mid] {
                max_row = i;
            }
        }

        if mid + 1 < n && mat[max_row][mid] < mat[max_row][mid + 1] {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    let max_row = (0..m).max_by_key(|&i| mat[i][left]).unwrap();
    vec![max_row as i32, left as i32]
}