impl Solution {
    pub fn nums_same_consec_diff(n: i32, k: i32) -> Vec<i32> {
        let mut result = Vec::new();

        if n == 1 {
            return (0..=9).collect();
        }

        for i in 1..=9 {
            Self::dfs(n, k, i, 1, &mut result);
        }

        result
    }

    fn dfs(n: i32, k: i32, current_num: i32, current_len: i32, result: &mut Vec<i32>) {
        if current_len == n {
            result.push(current_num);
            return;
        }

        let last_digit = current_num % 10;

        let next_digit_plus_k = last_digit + k;
        if next_digit_plus_k <= 9 {
            Self::dfs(n, k, current_num * 10 + next_digit_plus_k, current_len + 1, result);
        }

        let next_digit_minus_k = last_digit - k;
        if k != 0 && next_digit_minus_k >= 0 {
            Self::dfs(n, k, current_num * 10 + next_digit_minus_k, current_len + 1, result);
        }
    }
}