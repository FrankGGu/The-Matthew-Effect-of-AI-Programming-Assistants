impl Solution {
    pub fn nums_same_consec_diff(n: i32, k: i32) -> Vec<i32> {
        let mut result = Vec::new();
        for num in 1..=9 {
            Self::dfs(n - 1, k, num, &mut result);
        }
        result
    }

    fn dfs(remaining: i32, k: i32, current: i32, result: &mut Vec<i32>) {
        if remaining == 0 {
            result.push(current);
            return;
        }
        let last_digit = current % 10;
        if last_digit + k <= 9 {
            Self::dfs(remaining - 1, k, current * 10 + (last_digit + k), result);
        }
        if k != 0 && last_digit - k >= 0 {
            Self::dfs(remaining - 1, k, current * 10 + (last_digit - k), result);
        }
    }
}