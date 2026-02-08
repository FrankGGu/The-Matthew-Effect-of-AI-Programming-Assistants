impl Solution {
    pub fn count_special_subsequences(s: String) -> i32 {
        let mut dp0: i64 = 0; // Number of subsequences ending with '0'
        let mut dp1: i64 = 0; // Number of subsequences ending with '1' (must be preceded by '0's)
        let mut dp2: i64 = 0; // Number of subsequences ending with '2' (must be preceded by '0's and '1's)
        let m: i64 = 1_000_000_007;

        for c in s.chars() {
            match c {
                '0' => {
                    // A new '0' can either:
                    // 1. Start a new subsequence of '0's (this '0' itself).
                    // 2. Extend any existing subsequence of '0's (appending this '0' to them).
                    // So, the count of '0' subsequences doubles and adds 1 for the new single '0'.
                    dp0 = (2 * dp0 + 1) % m;
                }
                '1' => {
                    // A new '1' can either:
                    // 1. Extend any existing subsequence of '0's (forming '0...01').
                    // 2. Extend any existing subsequence of '0...01's (appending this '1' to them).
                    // So, the count of '0...01' subsequences doubles and adds the count of '0...0' subsequences.
                    dp1 = (2 * dp1 + dp0) % m;
                }
                '2' => {
                    // A new '2' can either:
                    // 1. Extend any existing subsequence of '0...01's (forming '0...01...12').
                    // 2. Extend any existing subsequence of '0...01...12's (appending this '2' to them).
                    // So, the count of '0...01...12' subsequences doubles and adds the count of '0...01...1' subsequences.
                    dp2 = (2 * dp2 + dp1) % m;
                }
                _ => {
                    // Ignore any other characters not specified in the problem.
                }
            }
        }

        dp2 as i32
    }
}