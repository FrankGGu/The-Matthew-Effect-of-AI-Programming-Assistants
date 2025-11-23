impl Solution {
    pub fn min_deletion_size(strs: Vec<String>) -> i32 {
        let n = strs.len();
        let m = strs[0].len();
        let mut dp = vec![1; m];

        for j in 0..m {
            for i in 0..j {
                if (0..n).all(|k| strs[k].as_bytes()[i] <= strs[k].as_bytes()[j]) {
                    dp[j] = dp[j].max(dp[i] + 1);
                }
            }
        }

        m - *dp.iter().max().unwrap()
    }
}