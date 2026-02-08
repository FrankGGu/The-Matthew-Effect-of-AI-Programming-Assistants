impl Solution {
    pub fn min_deletion_size(strs: Vec<String>) -> i32 {
        if strs.is_empty() {
            return 0;
        }

        let num_rows = strs.len();
        let num_cols = strs[0].len();
        let mut deleted_columns = 0;

        let strs_bytes: Vec<Vec<u8>> = strs.into_iter().map(|s| s.into_bytes()).collect();

        for j in 0..num_cols {
            for i in 0..num_rows - 1 {
                if strs_bytes[i][j] > strs_bytes[i + 1][j] {
                    deleted_columns += 1;
                    break;
                }
            }
        }

        deleted_columns
    }
}