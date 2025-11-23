impl Solution {
    pub fn number_of_beautiful_integers(low: i32, high: i32, k: i32) -> i32 {
        let high_str = high.to_string();
        let high_digits: Vec<u8> = high_str.chars().map(|c| c.to_digit(10).unwrap() as u8).collect();
        let high_count = Self::count_beautiful(&high_digits, k);

        let low_str = (low - 1).to_string();
        let low_digits: Vec<u8> = low_str.chars().map(|c| c.to_digit(10).unwrap() as u8).collect();
        let low_count = Self::count_beautiful(&low_digits, k);

        high_count - low_count
    }

    fn count_beautiful(digits: &[u8], k: i32) -> i32 {
        let n = digits.len();
        let mut memo = vec![vec![vec![vec![-1; k as usize]; 20]; 2]; n];
        Self::dfs(0, 0, 0, 0, true, false, digits, k, &mut memo)
    }

    fn dfs(
        pos: usize,
        even: i32,
        odd: i32,
        rem: i32,
        tight: bool,
        has_started: bool,
        digits: &[u8],
        k: i32,
        memo: &mut Vec<Vec<Vec<Vec<i32>>>>,
    ) -> i32 {
        if pos == digits.len() {
            return if has_started && rem == 0 && even == odd { 1 } else { 0 };
        }
        if !tight && has_started && memo[pos][even as usize][odd as usize][rem as usize] != -1 {
            return memo[pos][even as usize][odd as usize][rem as usize];
        }

        let max_digit = if tight { digits[pos] } else { 9 };
        let mut total = 0;

        for d in 0..=max_digit {
            let new_tight = tight && (d == max_digit);
            let new_has_started = has_started || (d != 0);
            let mut new_even = even;
            let mut new_odd = odd;

            if new_has_started {
                if d % 2 == 0 {
                    new_even += 1;
                } else {
                    new_odd += 1;
                }
            }

            let new_rem = (rem * 10 + d as i32) % k;
            total += Self::dfs(
                pos + 1,
                new_even,
                new_odd,
                new_rem,
                new_tight,
                new_has_started,
                digits,
                k,
                memo,
            );
        }

        if !tight && has_started {
            memo[pos][even as usize][odd as usize][rem as usize] = total;
        }

        total
    }
}