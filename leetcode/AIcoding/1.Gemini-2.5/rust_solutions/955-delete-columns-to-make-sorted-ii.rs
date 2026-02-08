impl Solution {
    pub fn min_deletion_size(strs: Vec<String>) -> i32 {
        let n = strs.len();
        if n <= 1 {
            return 0;
        }

        let m = strs[0].len();
        let mut deleted_count = 0;

        let mut is_sorted = vec![false; n];

        let str_bytes: Vec<&[u8]> = strs.iter().map(|s| s.as_bytes()).collect();

        for j in 0..m {
            let mut should_delete_current_column = false;
            for i in 1..n {
                if !is_sorted[i] {
                    if str_bytes[i][j] < str_bytes[i-1][j] {
                        should_delete_current_column = true;
                        break;
                    }
                }
            }

            if should_delete_current_column {
                deleted_count += 1;
            } else {
                for i in 1..n {
                    if !is_sorted[i] {
                        if str_bytes[i][j] > str_bytes[i-1][j] {
                            is_sorted[i] = true;
                        }
                    }
                }

                let mut all_pairs_sorted = true;
                for i in 1..n {
                    if !is_sorted[i] {
                        all_pairs_sorted = false;
                        break;
                    }
                }

                if all_pairs_sorted {
                    return deleted_count;
                }
            }
        }

        deleted_count
    }
}