impl Solution {
    pub fn min_deletion_size(strs: Vec<String>) -> i32 {
        let n = strs.len();
        if n == 0 {
            return 0;
        }
        let m = strs[0].len();
        if m == 0 {
            return 0;
        }

        let mut deleted_columns = 0;

        for j in 0..m {
            for i in 0..n - 1 {
                if strs[i].as_bytes()[j] > strs[i + 1].as_bytes()[j] {
                    deleted_columns += 1;
                    break;
                }
            }
        }

        deleted_columns
    }
}