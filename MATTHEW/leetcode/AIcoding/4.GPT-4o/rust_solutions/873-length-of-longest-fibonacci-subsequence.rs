impl Solution {
    pub fn len_longest_fib_subseq(arr: Vec<i32>) -> i32 {
        let n = arr.len();
        let mut index = std::collections::HashMap::new();
        for (i, &num) in arr.iter().enumerate() {
            index.insert(num, i);
        }
        let mut max_len = 0;
        let mut dp = vec![vec![2; n]; n];

        for j in (0..n).rev() {
            for i in (0..j).rev() {
                let sum = arr[i] + arr[j];
                if let Some(&k) = index.get(&sum) {
                    if k > j {
                        dp[i][j] = dp[j][k] + 1;
                        max_len = max_len.max(dp[i][j]);
                    }
                }
            }
        }

        if max_len >= 3 { max_len } else { 0 }
    }
}