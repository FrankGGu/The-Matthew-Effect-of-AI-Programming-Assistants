class Solution:
    def countPalindromicSubsequences(self, s: str) -> int:
        n = len(s)
        MOD = 10**9 + 7

        dp = [[0] * n for _ in range(n)]

        next_char = [[n] * 26 for _ in range(n)]
        prev_char = [[-1] * 26 for _ in range(n)]

        for i in range(n - 1, -1, -1):
            if i < n - 1:
                for char_code in range(26):
                    next_char[i][char_code] = next_char[i+1][char_code]
            next_char[i][ord(s[i]) - ord('a')] = i

        for i in range(n):
            if i > 0:
                for char_code in range(26):
                    prev_char[i][char_code] = prev_char[i-1][char_code]
            prev_char[i][ord(s[i]) - ord('a')] = i

        for i in range(n):
            dp[i][i] = 1

        for length in range(2, n + 1):
            for i in range(n - length + 1):
                j = i + length - 1

                if s[i] == s[j]:
                    char_code = ord(s[i]) - ord('a')

                    low = next_char[i+1][char_code]
                    high = prev_char[j-1][char_code]

                    if low > high:
                        dp[i][j] = (2 * dp[i+1][j-1] + 2) % MOD
                    elif low == high:
                        dp[i][j] = (2 * dp[i+1][j-1] + 1) % MOD
                    else:
                        dp[i][j] = (2 * dp[i+1][j-1] - dp[low+1][high-1] + MOD) % MOD
                else:
                    dp[i][j] = (dp[i+1][j] + dp[i][j-1] - dp[i+1][j-1] + MOD) % MOD

        return dp[0][n-1]