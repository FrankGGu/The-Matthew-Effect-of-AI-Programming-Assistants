impl Solution {
    pub fn number_of_people_aware_of_a_secret(n: i32, delay: i32, forget: i32) -> i32 {
        let n = n as usize;
        let delay = delay as usize;
        let forget = forget as usize;
        let modulo = 1_000_000_007;

        let mut dp = vec![0; n + 1];
        dp[1] = 1;

        let mut current_sharing_sum: i64 = 0;

        for i in 2..=n {
            if (i as isize - delay as isize) >= 1 {
                current_sharing_sum = (current_sharing_sum + dp[i - delay]) % modulo;
            }

            if (i as isize - forget as isize) >= 1 {
                current_sharing_sum = (current_sharing_sum - dp[i - forget] + modulo) % modulo;
            }

            dp[i] = current_sharing_sum;
        }

        let mut total_aware: i64 = 0;
        for i in ((n as isize - forget as isize + 1).max(1)) as usize ..=n {
            total_aware = (total_aware + dp[i]) % modulo;
        }

        total_aware as i32
    }
}