impl Solution {
    pub fn min_deletion_size(strs: Vec<String>) -> i32 {
        if strs.is_empty() {
            return 0;
        }

        let n = strs.len();
        let m = strs[0].len();

        if m == 0 {
            return 0;
        }

        // dp[i] stores the maximum length of a lexicographically sorted subsequence of columns
        // that ends with column i.
        let mut dp = vec![1; m]; 

        for i in 0..m {
            for j in 0..i {
                // Check if column j can precede column i lexicographically.
                // This means for every row k, strs[k][j] <= strs[k][i].
                let mut can_precede = true;
                for k in 0..n {
                    if strs[k].as_bytes()[j] > strs[k].as_bytes()[i] {
                        can_precede = false;
                        break;
                    }
                }

                if can_precede {
                    // If column j can precede column i, we can potentially extend
                    // the subsequence ending at j by adding column i.
                    dp[i] = dp[i].max(dp[j] + 1);
                }
            }
        }

        // The maximum number of columns that can be kept in a sorted manner
        // is the maximum value in the dp array.
        let max_kept_columns = *dp.iter().max().unwrap(); 

        // The problem asks for the maximum number of columns that can be deleted.
        // This is equivalent to total_columns - (maximum number of columns that can be kept).
        (m - max_kept_columns) as i32
    }
}