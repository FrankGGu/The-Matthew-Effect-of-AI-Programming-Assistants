pub fn maximum_rows(mat: Vec<Vec<i32>>, cols: Vec<i32>) -> i32 {
    let m = mat.len();
    let n = mat[0].len();
    let mut max_rows = 0;

    for mask in 0..(1 << n) {
        let mut covered_rows = 0;
        let mut valid_mask = true;

        for i in 0..m {
            let mut covered = true;
            for j in 0..n {
                if mat[i][j] == 1 && (mask & (1 << j)) == 0 {
                    covered = false;
                    break;
                }
            }
            if covered {
                covered_rows += 1;
            }
        }

        max_rows = max_rows.max(covered_rows);
    }

    max_rows
}