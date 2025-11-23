impl Solution {
    pub fn min_deletion_size(strs: Vec<String>) -> i32 {
        let n = strs.len();
        if n == 0 {
            return 0;
        }
        let m = strs[0].len();
        let mut dp = vec![1; m];
        let mut max_len = 1;

        for j in 1..m {
            for i in 0..j {
                let mut valid = true;
                for s in strs.iter() {
                    if s.as_bytes()[i] > s.as_bytes()[j] {
                        valid = false;
                        break;
                    }
                }
                if valid {
                    dp[j] = dp[j].max(dp[i] + 1);
                }
            }
            max_len = max_len.max(dp[j]);
        }

        (m - max_len) as i32
    }
}