impl Solution {
    pub fn number_of_powerful_int(start: i64, finish: i64, limit: i32, s: String) -> i64 {
        let s_len = s.len() as u32;
        let s_num = s.parse::<i64>().unwrap();
        let limit = limit as i64;

        fn count_powerful_numbers(upper: i64, limit: i64, s_len: u32, s_num: i64) -> i64 {
            let upper_str = upper.to_string();
            let n = upper_str.len() as u32;
            let upper_digits: Vec<i64> = upper_str.chars().map(|c| c.to_digit(10).unwrap() as i64).collect();

            let mut dp = vec![vec![vec![-1; 2]; 2]; 20];

            fn dfs(pos: usize, tight: bool, is_start: bool, dp: &mut Vec<Vec<Vec<i64>>>, upper_digits: &[i64], limit: i64, s_len: u32, s_num: i64) -> i64 {
                if pos == upper_digits.len() {
                    return if is_start { 1 } else { 0 };
                }

                if dp[pos][tight as usize][is_start as usize] != -1 {
                    return dp[pos][tight as usize][is_start as usize];
                }

                let max_digit = if tight { upper_digits[pos] } else { 9 };
                let mut res = 0;

                if !is_start {
                    res += dfs(pos + 1, tight && (0 == max_digit), false, dp, upper_digits, limit, s_len, s_num);
                }

                let start_digit = if is_start { 1 } else { 0 };
                for d in start_digit..=max_digit.min(limit) {
                    res += dfs(pos + 1, tight && (d == max_digit), true, dp, upper_digits, limit, s_len, s_num);
                }

                if pos + s_len as usize == upper_digits.len() && is_start {
                    let suffix = s_num;
                    let prefix_upper = if tight {
                        let prefix_str: String = upper_digits[..pos].iter().map(|&d| (d as u8 + b'0') as char).collect();
                        if prefix_str.is_empty() { 0 } else { prefix_str.parse::<i64>().unwrap() }
                    } else {
                        i64::MAX
                    };
                    let num = if pos == 0 { suffix } else { prefix_upper * 10i64.pow(s_len) + suffix };
                    if num <= upper && (pos == 0 || prefix_upper <= 10i64.pow(pos as u32) - 1) {
                        res += 1;
                    }
                }

                dp[pos][tight as usize][is_start as usize] = res;
                res
            }

            dfs(0, true, false, &mut dp, &upper_digits, limit, s_len, s_num)
        }

        let upper_finish = count_powerful_numbers(finish, limit, s_len, s_num);
        let upper_start = count_powerful_numbers(start - 1, limit, s_len, s_num);
        upper_finish - upper_start
    }
}