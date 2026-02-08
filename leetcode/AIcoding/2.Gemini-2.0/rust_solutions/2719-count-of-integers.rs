impl Solution {
    pub fn count_integers(num1: String, num2: String, min_sum: i32, max_sum: i32) -> i32 {
        let mod_val = 1_000_000_007;
        let n1 = num1.len();
        let n2 = num2.len();

        fn solve(num: String, min_sum: i32, max_sum: i32, mod_val: i32) -> i32 {
            let n = num.len();
            let digits: Vec<i32> = num.chars().map(|c| (c as u8 - b'0') as i32).collect();
            let mut dp = vec![vec![vec![0; 2]; max_sum as usize + 1]; n + 1];
            dp[0][0][1] = 1;

            for i in 0..n {
                for sum in 0..=max_sum as usize {
                    for tight in 0..=1 {
                        if dp[i][sum][tight] == 0 {
                            continue;
                        }

                        let upper_bound = if tight == 1 { digits[i] } else { 9 };

                        for digit in 0..=upper_bound {
                            let new_sum = sum + digit as usize;
                            if new_sum <= max_sum as usize {
                                let new_tight = if tight == 1 && digit == digits[i] { 1 } else { 0 };
                                dp[i + 1][new_sum][new_tight] = (dp[i + 1][new_sum][new_tight] + dp[i][sum][tight]) % mod_val;
                            }
                        }
                    }
                }
            }

            let mut ans = 0;
            for sum in min_sum as usize..=max_sum as usize {
                ans = (ans + dp[n][sum][0] + dp[n][sum][1]) % mod_val;
            }
            ans
        }

        let ans2 = solve(num2, min_sum, max_sum, mod_val);
        let mut num1_minus_one = num1.clone();
        let mut i = num1_minus_one.len() - 1;
        while i >= 0 {
            if num1_minus_one.as_bytes()[i] == b'0' {
                num1_minus_one.replace_range(i..=i, "9");
                if i == 0 {
                    num1_minus_one = "0".repeat(num1_minus_one.len()).to_string();
                    break;
                }
                i -= 1;
            } else {
                num1_minus_one.replace_range(i..=i, &((num1_minus_one.as_bytes()[i] - b'0' - 1) as char).to_string());
                break;
            }
        }

        let ans1 = solve(num1_minus_one, min_sum, max_sum, mod_val);
        let mut sum_num1 = 0;
        for c in num1.chars() {
            sum_num1 += (c as u8 - b'0') as i32;
        }
        let mut add_back = 0;
        if sum_num1 >= min_sum && sum_num1 <= max_sum {
            add_back = 1;
        }

        ((ans2 - ans1 + add_back + mod_val) % mod_val)
    }
}