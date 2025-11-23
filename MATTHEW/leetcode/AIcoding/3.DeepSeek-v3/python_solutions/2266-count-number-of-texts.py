class Solution:
    def countTexts(self, pressedKeys: str) -> int:
        MOD = 10**9 + 7
        n = len(pressedKeys)
        dp = [0] * (n + 1)
        dp[0] = 1

        for i in range(1, n + 1):
            dp[i] = dp[i - 1] % MOD
            if i >= 2 and pressedKeys[i - 1] == pressedKeys[i - 2]:
                dp[i] = (dp[i] + dp[i - 2]) % MOD
                if i >= 3 and pressedKeys[i - 1] == pressedKeys[i - 3]:
                    dp[i] = (dp[i] + dp[i - 3]) % MOD
                    if i >= 4 and pressedKeys[i - 1] in {'7', '9'} and pressedKeys[i - 1] == pressedKeys[i - 4]:
                        dp[i] = (dp[i] + dp[i - 4]) % MOD
        return dp[n] % MOD