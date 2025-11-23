impl Solution {
    pub fn minimum_substring_partition(s: String) -> i32 {
        let n = s.len();
        let s_bytes = s.as_bytes();

        let mut dp = vec![n as i32 + 1; n + 1];
        dp[0] = 0;

        for i in 1..=n {
            for j in 0..i {
                if Self::is_valid_substring(s_bytes, j, i - 1) {
                    dp[i] = dp[i].min(dp[j] + 1);
                }
            }
        }

        dp[n]
    }

    fn is_valid_substring(s_bytes: &[u8], start: usize, end: usize) -> bool {
        let mut counts = [0; 26];
        for k in start..=end {
            counts[(s_bytes[k] - b'a') as usize] += 1;
        }

        let mut first_freq = -1;
        for &count in counts.iter() {
            if count == 0 {
                continue;
            }
            if first_freq == -1 {
                first_freq = count;
            } else if count != first_freq {
                return false;
            }
        }
        true
    }
}