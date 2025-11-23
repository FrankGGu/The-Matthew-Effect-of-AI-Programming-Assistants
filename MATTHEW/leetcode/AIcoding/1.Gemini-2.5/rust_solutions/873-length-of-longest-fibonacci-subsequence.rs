use std::collections::HashMap;
use std::cmp::max;

impl Solution {
    pub fn len_longest_fib_subseq(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut val_to_idx: HashMap<i32, usize> = HashMap::new();
        for (i, &num) in arr.iter().enumerate() {
            val_to_idx.insert(num, i);
        }

        let mut dp: Vec<Vec<i32>> = vec![vec![0; n]; n];
        let mut max_len = 0;

        for j in 0..n {
            for i in 0..j {
                let target = arr[j] - arr[i];

                // For arr[k], arr[i], arr[j] to be a Fibonacci-like sequence:
                // 1. arr[k] + arr[i] = arr[j]
                // 2. arr[k] < arr[i] (since the sequence must be strictly increasing and arr[i] is the middle element)
                // 3. arr[k] must exist in the input array.
                if target < arr[i] && val_to_idx.contains_key(&target) {
                    let k = *val_to_idx.get(&target).unwrap();

                    // If dp[k][i] is 0, it means arr[k] and arr[i] themselves
                    // are just a pair, not part of a longer Fibonacci-like sequence yet.
                    // In this case, arr[k], arr[i], arr[j] forms a new sequence of length 3.
                    // If dp[k][i] > 0, it means arr[k] and arr[i] are the last two
                    // elements of an existing Fibonacci-like sequence of length dp[k][i].
                    // Extending it with arr[j] increases its length by 1.
                    dp[i][j] = (if dp[k][i] == 0 { 2 } else { dp[k][i] }) + 1;
                    max_len = max(max_len, dp[i][j]);
                }
            }
        }

        // A Fibonacci-like subsequence must have a length of at least 3.
        // If max_len is less than 3, it means no such subsequence was found.
        if max_len < 3 { 0 } else { max_len }
    }
}