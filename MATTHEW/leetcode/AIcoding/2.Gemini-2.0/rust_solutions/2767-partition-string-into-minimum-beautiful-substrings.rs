impl Solution {
    pub fn beautiful_partitions(s: String, k: i32) -> i32 {
        let n = s.len();
        let chars: Vec<char> = s.chars().collect();

        if !['2', '3', '5', '7'].contains(&chars[0]) {
            return -1;
        }

        let mut dp = vec![i32::MAX; n + 1];
        dp[0] = 0;

        for i in 0..n {
            if dp[i] == i32::MAX {
                continue;
            }

            for j in i + 1..=n {
                let sub = &s[i..j];
                let first_char = chars[i];

                if !['2', '3', '5', '7'].contains(&first_char) {
                    continue;
                }

                if sub.len() > 1 && sub.starts_with('0') {
                    continue;
                }

                if sub.len() > k as usize {
                    continue;
                }

                let num = sub.parse::<i32>().unwrap();
                if num >= k {
                    dp[j] = dp[j].min(dp[i] + 1);
                }
            }
        }

        if dp[n] == i32::MAX {
            return -1;
        } else {
            return dp[n];
        }
    }
}