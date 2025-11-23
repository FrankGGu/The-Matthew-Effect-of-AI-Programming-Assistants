impl Solution {
    pub fn minimum_substrings_in_partition(target: String) -> i32 {
        let n = target.len();
        let s = target.as_bytes();
        let mut dp = vec![n as i32; n + 1];
        dp[0] = 0;

        for i in 0..n {
            let mut count = [0; 26];
            let mut max_freq = 0;
            for j in i..n {
                let idx = (s[j] - b'a') as usize;
                count[idx] += 1;
                if count[idx] > max_freq {
                    max_freq = count[idx];
                }
                let len = j - i + 1;
                if max_freq * 2 <= len && (len % 2 == 0) {
                    if dp[i] + 1 < dp[j + 1] {
                        dp[j + 1] = dp[i] + 1;
                    }
                }
            }
        }
        dp[n]
    }
}