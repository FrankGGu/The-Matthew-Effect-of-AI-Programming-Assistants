impl Solution {
    pub fn count_numbers_with_unique_digits(n: i32) -> i32 {
        if n == 0 {
            return 1;
        }

        let mut dp = vec![0; (n + 1) as usize];
        dp[1] = 10;

        let mut ans = dp[1];
        let mut product = 9;

        for i in 2..=n {
            if i > 10 {
                break;
            }

            product *= (10 - (i - 1));
            dp[i as usize] = product;
            ans += dp[i as usize];
        }

        ans
    }
}

struct Solution;