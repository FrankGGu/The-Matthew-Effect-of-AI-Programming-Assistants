impl Solution {
    pub fn palindrome_partitioning_iii(s: String, k: i32) -> i32 {
        let n = s.len();
        let k = k as usize;
        let s_chars: Vec<char> = s.chars().collect();

        // Step 1: Precompute cost[i][j] - minimum changes to make s[i..j] a palindrome
        // cost[i][j] will store the cost for substring s[i..j]
        let mut cost = vec![vec![0; n]; n];

        // Fill cost table for substrings of length 2 to n
        for len in 2..=n {
            for i in 0..=(n - len) {
                let j = i + len - 1;
                // The cost for s[i..j] depends on s[i+1..j-1] and characters s[i], s[j]
                if s_chars[i] == s_chars[j] {
                    cost[i][j] = cost[i + 1][j - 1];
                } else {
                    cost[i][j] = cost[i + 1][j - 1] + 1;
                }
            }
        }
        // Substrings of length 1 (s[i..i]) have cost 0, which is handled by default initialization.
        // Substrings s[i..j] where i > j (empty or invalid range) are considered to have cost 0,
        // which is also handled by default initialization, and used correctly when len=2 (e.g., cost[i+1][i]).

        // Step 2: DP to find minimum changes for k partitions
        // dp[i][j] = minimum changes to partition s[0..i] into j palindromic substrings
        // i ranges from 0 to n-1 (inclusive, representing the end index of the prefix)
        // j ranges from 1 to k (inclusive, representing the number of partitions)
        let mut dp = vec![vec![i32::MAX / 2; k + 1]; n]; // Use MAX/2 to avoid overflow on addition

        // Base case: j = 1 (partition s[0..i] into 1 part)
        for i in 0..n {
            dp[i][1] = cost[0][i];
        }

        // Fill DP table for j partitions
        for j in 2..=k { // Number of partitions
            for i in (j - 1)..n { // End index of the current prefix s[0..i]
                                  // A prefix of length (i+1) must have at least j characters to be partitioned into j parts,
                                  // so i+1 >= j => i >= j-1.

                // Iterate through all possible split points 'p' for the (j-1)-th partition
                // 'p' is the end index of the prefix s[0..p] which is partitioned into (j-1) parts.
                // The last partition is then s[p+1..i].
                for p in (j - 2)..i { 
                    // s[0..p] must have at least (j-1) characters, so p+1 >= j-1 => p >= j-2.
                    // The last partition s[p+1..i] must be non-empty, so p+1 <= i => p <= i-1.
                    dp[i][j] = dp[i][j].min(dp[p][j - 1] + cost[p + 1][i]);
                }
            }
        }

        // The final answer is the minimum changes to partition s[0..n-1] into k parts
        dp[n - 1][k]
    }
}