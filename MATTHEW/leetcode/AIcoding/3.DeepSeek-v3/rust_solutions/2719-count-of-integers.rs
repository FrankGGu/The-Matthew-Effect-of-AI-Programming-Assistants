impl Solution {
    pub fn count(num1: String, num2: String, min_sum: i32, max_sum: i32) -> i32 {
        const MOD: i32 = 1_000_000_007;

        fn dfs(pos: usize, tight: bool, sum: i32, digits: &Vec<u8>, memo: &mut Vec<Vec<Vec<i32>>>) -> i32 {
            if pos == digits.len() {
                return if sum >= 0 { 1 } else { 0 };
            }
            if memo[pos][tight as usize][sum as usize] != -1 {
                return memo[pos][tight as usize][sum as usize];
            }
            let limit = if tight { digits[pos] } else { 9 };
            let mut res = 0;
            for d in 0..=limit {
                let new_tight = tight && (d == limit);
                let new_sum = sum - d as i32;
                if new_sum >= 0 {
                    res = (res + dfs(pos + 1, new_tight, new_sum, digits, memo)) % MOD;
                }
            }
            memo[pos][tight as usize][sum as usize] = res;
            res
        }

        fn calculate(s: String, max_sum: i32) -> i32 {
            let digits: Vec<u8> = s.chars().map(|c| c.to_digit(10).unwrap() as u8).collect();
            let n = digits.len();
            let mut memo = vec![vec![vec![-1; (max_sum + 1) as usize]; 2]; n];
            dfs(0, true, max_sum, &digits, &mut memo)
        }

        let count_high = calculate(num2, max_sum);
        let count_low = calculate(num1, min_sum - 1);
        let total = (count_high - count_low) % MOD;
        if total < 0 {
            total + MOD
        } else {
            total
        }
    }
}