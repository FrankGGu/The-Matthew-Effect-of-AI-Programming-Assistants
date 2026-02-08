impl Solution {
    pub fn count_house_placements(n: i32) -> i32 {
        let n = n as usize;
        let modulo = 1_000_000_007;

        // Let dp[i] be the number of ways to place houses on 'i' plots on a single side of the street.
        // A plot can either have a house or be empty.
        // If plot 'i' has a house, then plot 'i-1' must be empty. The number of ways is dp[i-2].
        // If plot 'i' is empty, then plot 'i-1' can either have a house or be empty. The number of ways is dp[i-1].
        // So, dp[i] = dp[i-1] + dp[i-2]. This is a Fibonacci-like sequence.

        // Base cases for one side:
        // dp[0]: For 0 plots, there is 1 way (an empty street).
        // dp[1]: For 1 plot, there are 2 ways (House, Empty).

        // `a` will store dp[i-2] and `b` will store dp[i-1] as we iterate.
        let mut a: i64 = 1; // Represents dp[0]
        let mut b: i64 = 2; // Represents dp[1]

        // The loop calculates dp[i] for i from 2 up to n.
        // If n = 1, the loop `2..=1` will not execute, and `b` will correctly hold dp[1] (which is 2).
        for _i in 2..=n {
            let next_b = (a + b) % modulo;
            a = b;
            b = next_b;
        }

        // After the loop, `b` holds dp[n], the number of ways to place houses on `n` plots on one side.
        // Since the placements on the two sides of the street are independent,
        // the total number of ways is (dp[n] * dp[n]) % modulo.
        ((b * b) % modulo) as i32
    }
}