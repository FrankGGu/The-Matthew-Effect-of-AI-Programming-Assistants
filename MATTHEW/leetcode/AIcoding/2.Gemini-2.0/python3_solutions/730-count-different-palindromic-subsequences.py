class Solution:
    def countPalindromicSubsequences(self, s: str) -> int:
        n = len(s)
        MOD = 10**9 + 7
        dp = [[[0] * 4 for _ in range(n)] for _ in range(n)]
        chars = {'a': 0, 'b': 1, 'c': 2, 'd': 3}

        for i in range(n):
            dp[i][i][chars[s[i]]] = 1

        for length in range(2, n + 1):
            for i in range(n - length + 1):
                j = i + length - 1
                for char_index in range(4):
                    char = 'abcd'[char_index]
                    if s[i] == char and s[j] == char:
                        inner_sum = 0
                        for k in range(4):
                            inner_sum = (inner_sum + dp[i+1][j-1][k]) % MOD
                        dp[i][j][char_index] = (2 + inner_sum) % MOD
                    elif s[i] == char:
                        dp[i][j][char_index] = dp[i][j-1][char_index]
                    elif s[j] == char:
                        dp[i][j][char_index] = dp[i+1][j][char_index]
                    else:
                        dp[i][j][char_index] = dp[i+1][j-1][char_index]

        ans = 0
        for char_index in range(4):
            ans = (ans + dp[0][n-1][char_index]) % MOD
        return ans