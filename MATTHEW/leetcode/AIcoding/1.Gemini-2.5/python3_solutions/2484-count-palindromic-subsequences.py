class Solution:
    def countPalindromicSubsequences(self, s: str) -> int:
        n = len(s)
        if n == 0:
            return 0

        MOD = 10**9 + 7

        dp = [[0] * n for _ in range(n)]

        for i in range(n):
            dp[i][i] = 1

        for length in range(2, n + 1):
            for i in range(n - length + 1):
                j = i + length - 1

                if s[i] == s[j]:
                    # If characters at i and j match:
                    # The palindromic subsequences are:
                    # 1. Palindromes in s[i...j-1] (dp[i][j-1])
                    # 2. Palindromes in s[i+1...j] (dp[i+1][j])
                    # 3. Plus 1 for the palindrome s[i]s[j] itself.
                    # The sum dp[i][j-1] + dp[i+1][j] + 1 correctly accounts for all cases.
                    # This can be derived as:
                    # (dp[i][j-1] + dp[i+1][j] - dp[i+1][j-1])  <- palindromes not using both s[i] and s[j]
                    # + (1 + dp[i+1][j-1])                     <- new palindromes using both s[i] and s[j]
                    # = dp[i][j-1] + dp[i+1][j] + 1
                    dp[i][j] = (dp[i][j-1] + dp[i+1][j] + 1) % MOD
                else:
                    # If characters at i and j do not match:
                    # Palindromic subsequences are formed by:
                    # 1. Palindromes in s[i...j-1] (not using s[j])
                    # 2. Palindromes in s[i+1...j] (not using s[i])
                    # We subtract dp[i+1][j-1] to avoid double counting palindromes that are in both ranges.
                    dp[i][j] = (dp[i][j-1] + dp[i+1][j] - dp[i+1][j-1] + MOD) % MOD

        return dp[0][n-1]