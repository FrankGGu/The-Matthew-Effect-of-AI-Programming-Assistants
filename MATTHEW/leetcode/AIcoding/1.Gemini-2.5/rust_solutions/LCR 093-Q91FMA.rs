use std::collections::HashMap;

impl Solution {
    pub fn len_longest_fib_subsequence(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut val_to_idx: HashMap<i32, usize> = HashMap::new();
        for (i, &num) in arr.iter().enumerate() {
            val_to_idx.insert(num, i);
        }

        let mut dp: Vec<Vec<i32>> = vec![vec![0; n]; n];
        let mut max_len = 0;

        for j in 0..n {
            for i in 0..j {
                let prev_val = arr[j] - arr[i];

                if prev_val < arr[i] {
                    if let Some(&k) = val_to_idx.get(&prev_val) {
                        dp[i][j] = if dp[k][i] == 0 { 3 } else { dp[k][i] + 1 };
                        max_len = max_len.max(dp[i][j]);
                    }
                }
            }
        }

        max_len
    }
}