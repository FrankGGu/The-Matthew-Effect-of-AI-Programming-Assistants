impl Solution {
    pub fn nums_same_consec_diff(n: i32, k: i32) -> Vec<i32> {
        let mut result = Vec::new();
        for i in 1..=9 {
            Self::dfs(i, n - 1, k, &mut result);
        }
        result
    }

    fn dfs(num: i32, n: i32, k: i32, result: &mut Vec<i32>) {
        if n == 0 {
            result.push(num);
            return;
        }

        let last_digit = num % 10;
        if last_digit + k <= 9 {
            Self::dfs(num * 10 + (last_digit + k), n - 1, k, result);
        }
        if k != 0 && last_digit - k >= 0 {
            Self::dfs(num * 10 + (last_digit - k), n - 1, k, result);
        }
    }
}