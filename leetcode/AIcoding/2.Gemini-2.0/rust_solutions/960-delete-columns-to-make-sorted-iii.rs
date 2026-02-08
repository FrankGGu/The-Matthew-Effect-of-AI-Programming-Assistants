impl Solution {
    pub fn min_deletion_size(strs: Vec<String>) -> i32 {
        let n = strs.len();
        let m = strs[0].len();
        let strs: Vec<Vec<char>> = strs.into_iter().map(|s| s.chars().collect()).collect();
        let mut dp = vec![1; m];
        let mut ans = 0;

        for i in 1..m {
            for j in 0..i {
                let mut sorted = true;
                for k in 0..n {
                    if strs[k][j] > strs[k][i] {
                        sorted = false;
                        break;
                    }
                }
                if sorted {
                    dp[i] = dp[i].max(dp[j] + 1);
                }
            }
        }

        let max_len = *dp.iter().max().unwrap();
        ans = m as i32 - max_len as i32;

        ans
    }
}