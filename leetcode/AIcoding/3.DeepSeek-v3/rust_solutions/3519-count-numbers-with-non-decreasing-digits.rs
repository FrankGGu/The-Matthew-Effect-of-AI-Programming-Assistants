impl Solution {
    pub fn count_numbers_with_non_decreasing_digits(n: i32) -> i32 {
        if n == 0 {
            return 1;
        }
        let mut dp = vec![1; 10];
        for _ in 1..n {
            for j in 1..10 {
                dp[j] += dp[j - 1];
            }
        }
        dp.iter().sum()
    }
}