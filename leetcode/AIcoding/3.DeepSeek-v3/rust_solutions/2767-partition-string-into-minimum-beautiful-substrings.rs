impl Solution {
    pub fn minimum_beautiful_substrings(s: String) -> i32 {
        let n = s.len();
        let chars: Vec<char> = s.chars().collect();
        let mut dp = vec![n + 1; n + 1];
        dp[0] = 0;

        for i in 1..=n {
            if chars[i - 1] == '0' {
                continue;
            }
            let mut num = 0;
            for j in i..=n {
                num = (num << 1) + if chars[j - 1] == '1' { 1 } else { 0 };
                if Self::is_power_of_five(num) {
                    dp[j] = dp[j].min(dp[i - 1] + 1);
                }
            }
        }

        if dp[n] <= n {
            dp[n] as i32
        } else {
            -1
        }
    }

    fn is_power_of_five(mut num: i32) -> bool {
        if num == 0 {
            return false;
        }
        while num % 5 == 0 {
            num /= 5;
        }
        num == 1
    }
}