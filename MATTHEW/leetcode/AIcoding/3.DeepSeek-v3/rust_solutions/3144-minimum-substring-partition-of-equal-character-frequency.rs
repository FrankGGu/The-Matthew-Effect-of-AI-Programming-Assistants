impl Solution {
    pub fn minimum_substrings_in_partition(s: String) -> i32 {
        let s = s.chars().collect::<Vec<char>>();
        let n = s.len();
        let mut dp = vec![n as i32; n + 1];
        dp[0] = 0;

        for i in 1..=n {
            let mut freq = [0; 26];
            for j in (0..i).rev() {
                freq[(s[j] as u8 - b'a') as usize] += 1;
                let mut is_valid = true;
                let mut count = -1;
                for &f in &freq {
                    if f == 0 {
                        continue;
                    }
                    if count == -1 {
                        count = f;
                    } else if f != count {
                        is_valid = false;
                        break;
                    }
                }
                if is_valid {
                    dp[i] = dp[i].min(dp[j] + 1);
                }
            }
        }
        dp[n]
    }
}