impl Solution {
    pub fn count_stepping_numbers(low: String, high: String) -> i32 {
        let low_num = low.parse::<i64>().unwrap();
        let high_num = high.parse::<i64>().unwrap();

        let mut memo = vec![vec![vec![-1; 10]; 20]; 2];

        fn dfs(pos: usize, tight: bool, prev_digit: i32, digits: &Vec<char>, memo: &mut Vec<Vec<Vec<i32>>>, is_zero: bool) -> i32 {
            if pos == digits.len() {
                return if is_zero { 0 } else { 1 };
            }

            let tight_flag = if tight { 1 } else { 0 };
            if memo[tight_flag][pos][prev_digit as usize] != -1 && !is_zero {
                return memo[tight_flag][pos][prev_digit as usize];
            }

            let limit = if tight { digits[pos] as i32 - '0' as i32 } else { 9 };
            let mut res = 0;

            for d in 0..=limit {
                let new_tight = tight && (d == limit);
                let new_is_zero = is_zero && (d == 0);

                if is_zero {
                    res += dfs(pos + 1, new_tight, d, digits, memo, new_is_zero);
                } else {
                    if (prev_digit - d).abs() == 1 {
                        res += dfs(pos + 1, new_tight, d, digits, memo, new_is_zero);
                    }
                }
            }

            if !is_zero {
                memo[tight_flag][pos][prev_digit as usize] = res;
            }
            res
        }

        let high_digits: Vec<char> = high.chars().collect();
        let count_high = dfs(0, true, 0, &high_digits, &mut memo, true);

        let low_digits: Vec<char> = low.chars().collect();
        let mut memo = vec![vec![vec![-1; 10]; 20]; 2];
        let count_low = dfs(0, true, 0, &low_digits, &mut memo, true);

        let is_low_stepping = {
            let digits: Vec<i32> = low.chars().map(|c| c as i32 - '0' as i32).collect();
            let mut valid = true;
            for i in 1..digits.len() {
                if (digits[i-1] - digits[i]).abs() != 1 {
                    valid = false;
                    break;
                }
            }
            valid
        };

        (count_high - count_low + if is_low_stepping { 1 } else { 0 }) as i32
    }
}