impl Solution {
    pub fn num_distinct(s: String, t: String) -> i32 {
        let s_chars: Vec<char> = s.chars().collect();
        let t_chars: Vec<char> = t.chars().collect();

        let n = s_chars.len();
        let m = t_chars.len();

        // If t is longer than s, it's impossible to form t as a subsequence of s.
        if m > n {
            return 0;
        }

        // dp[j] will store the number of distinct subsequences of s[0...i-1] that equal t[0...j-1]
        // using only O(m) space.
        // Use i64 to prevent potential intermediate overflows, as the problem constraints
        // (n, m <= 100) could theoretically lead to values exceeding i32::MAX.
        // The final result is cast to i32 as per problem signature.
        let mut dp: Vec<i64> = vec![0; m + 1];

        // Base case: An empty string t (t_len = 0) can be formed in 1 way from any s
        // (by deleting all characters of s).
        dp[0] = 1;

        // Iterate through s_chars
        for i in 0..n {
            // Iterate through t_chars backwards to use values from the previous row (dp[i-1])
            // before they are overwritten by current row (dp[i]) calculations.
            // j goes from m down to 1 (inclusive)
            for j in (1..=m).rev() {
                if s_chars[i] == t_chars[j - 1] {
                    // If characters match, we have two possibilities:
                    // 1. Match s_chars[i] with t_chars[j-1]: Add dp[j-1] (number of ways to form t[0...j-2] from s[0...i-1])
                    // 2. Don't match s_chars[i] (i.e., delete s_chars[i]): Add dp[j] (number of ways to form t[0...j-1] from s[0...i-1])
                    // Since dp[j] already holds the value for the second case (from the previous iteration of i),
                    // we just need to add dp[j-1] (which is still from the previous iteration of i because j is decreasing).
                    dp[j] += dp[j - 1];
                }
                // If s_chars[i] != t_chars[j-1], then s_chars[i] cannot be used to form t_chars[j-1].
                // So s_chars[i] must be effectively "deleted". The count remains dp[j] (number of ways
                // to form t[0...j-1] from s[0...i-1]). No change is needed for dp[j] in this case,
                // as it already holds the correct value from the previous iteration of i.
            }
        }

        dp[m] as i32
    }
}