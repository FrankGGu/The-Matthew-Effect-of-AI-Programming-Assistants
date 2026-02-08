use std::collections::HashMap;

impl Solution {
    pub fn len_longest_fib_subseq(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut index = HashMap::new();
        for (i, &num) in arr.iter().enumerate() {
            index.insert(num, i);
        }
        let mut dp = vec![vec![2; n]; n];
        let mut max_len = 0;

        for k in 0..n {
            for j in 0..k {
                if let Some(&i) = index.get(&(arr[k] - arr[j])) {
                    if i < j {
                        dp[j][k] = dp[i][j] + 1;
                        if dp[j][k] > max_len {
                            max_len = dp[j][k];
                        }
                    }
                }
            }
        }

        if max_len >= 3 {
            max_len
        } else {
            0
        }
    }
}