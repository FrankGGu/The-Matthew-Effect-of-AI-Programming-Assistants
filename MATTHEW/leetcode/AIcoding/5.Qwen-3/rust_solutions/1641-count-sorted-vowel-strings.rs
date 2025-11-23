struct Solution;

impl Solution {
    pub fn count_sorted_vowel_strings(n: i32) -> i32 {
        let mut dp = [1; 5];

        for _ in 1..n {
            for i in 1..5 {
                dp[i] += dp[i - 1];
            }
        }

        dp.iter().sum()
    }
}