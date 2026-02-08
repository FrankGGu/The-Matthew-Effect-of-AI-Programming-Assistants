impl Solution {
    pub fn number_of_special_numbers(n: i32) -> i32 {
        let s = n.to_string();
        let digits: Vec<char> = s.chars().collect();
        let m = digits.len();
        let mut dp = vec![vec![vec![-1; 2]; 2]; m];

        fn dfs(pos: usize, tight: bool, leading_zero: bool, digits: &Vec<char>, memo: &mut Vec<Vec<Vec<i32>>>) -> i32 {
            if pos == digits.len() {
                return if leading_zero { 0 } else { 1 };
            }
            if memo[pos][tight as usize][leading_zero as usize] != -1 {
                return memo[pos][tight as usize][leading_zero as usize];
            }

            let limit = if tight { digits[pos].to_digit(10).unwrap() as i32 } else { 9 };
            let mut res = 0;

            for d in 0..=limit {
                let new_tight = tight && (d == limit);
                let new_leading_zero = leading_zero && (d == 0);

                if new_leading_zero {
                    res += dfs(pos + 1, new_tight, new_leading_zero, digits, memo);
                } else {
                    if d == 0 || d == 1 || d == 8 || d == 6 || d == 9 {
                        res += dfs(pos + 1, new_tight, new_leading_zero, digits, memo);
                    }
                }
            }

            memo[pos][tight as usize][leading_zero as usize] = res;
            res
        }

        let total = dfs(0, true, true, &digits, &mut dp);
        total - 1
    }
}