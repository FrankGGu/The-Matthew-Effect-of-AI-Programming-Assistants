class Solution {
    public int countPalindromicSubsequences(String s) {
        int N = s.length();
        int MOD = 1_000_000_007;

        int[][] dp = new int[N][N];

        // next[i][char_code] stores the index of the next occurrence of char_code
        // at or after index i. If not found, it's N.
        int[][] next = new int[N + 1][26];
        for (int c = 0; c < 26; c++) {
            next[N][c] = N; // Sentinel value
        }
        for (int i = N - 1; i >= 0; i--) {
            for (int c = 0; c < 26; c++) {
                next[i][c] = next[i + 1][c];
            }
            next[i][s.charAt(i) - 'a'] = i;
        }

        // prev[i][char_code] stores the index of the previous occurrence of char_code
        // at or before index i. If not found, it's -1.
        int[][] prev = new int[N][26];
        for (int c = 0; c < 26; c++) {
            prev[0][c] = -1; // Sentinel value
        }
        prev[0][s.charAt(0) - 'a'] = 0;
        for (int i = 1; i < N; i++) {
            for (int c = 0; c < 26; c++) {
                prev[i][c] = prev[i - 1][c];
            }
            prev[i][s.charAt(i) - 'a'] = i;
        }

        // Base cases: length 1 palindromes
        for (int i = 0; i < N; i++) {
            dp[i][i] = 1;
        }

        // Fill DP table for lengths from 2 to N
        for (int len = 2; len <= N; len++) {
            for (int i = 0; i <= N - len; i++) {
                int j = i + len - 1;

                if (s.charAt(i) == s.charAt(j)) {
                    int charCode = s.charAt(i) - 'a';

                    // Find the first occurrence of charCode in s[i+1...j-1]
                    int low = next[i + 1][charCode];
                    // Find the last occurrence of charCode in s[i+1...j-1]
                    int high = prev[j - 1][charCode];

                    // The term 2 * dp[i+1][j-1] accounts for:
                    // 1. Palindromes in s[i+1...j-1] (these don't use s[i] or s[j] as outer chars)
                    // 2. Palindromes of form c X c where X is a palindrome in s[i+1...j-1]
                    dp[i][j] = (2 * dp[i + 1][j - 1]) % MOD;

                    if (low > high) {
                        // Case 1: No occurrences of charCode in s[i+1...j-1]
                        // Add 2 for 'c' (single char) and 'cc' (two chars)
                        dp[i][j] = (dp[i][j] + 2) % MOD;
                    } else if (low == high) {
                        // Case 2: Exactly one occurrence of charCode in s[i+1...j-1]
                        // Add 1 for 'c' (single char, which is 'cc' from s[i]s[j]).
                        // The single 'c' is already covered by dp[i+1][j-1] (as X).
                        // So only 'cc' is new.
                        dp[i][j] = (dp[i][j] + 1) % MOD;
                    } else { // low < high
                        // Case 3: Multiple occurrences of charCode in s[i+1...j-1]
                        // Palindromes of form c Y c where Y is a palindrome in s[low+1...high-1]
                        // are counted twice: once as s[i] Y s[j] and once as s[low] Y s[high].
                        // Subtract dp[low+1][high-1] to correct for this overcounting.
                        dp[i][j] = (dp[i][j] - dp[low + 1][high - 1] + MOD) % MOD;
                    }
                } else {
                    // If s[i] != s[j], use inclusion-exclusion principle
                    // Palindromes in s[i+1...j] + Palindromes in s[i...j-1] - Palindromes in s[i+1...j-1] (overlap)
                    dp[i][j] = (dp[i + 1][j] + dp[i][j - 1] - dp[i + 1][j - 1] + MOD) % MOD;
                }
            }
        }

        return dp[0][N - 1];
    }
}