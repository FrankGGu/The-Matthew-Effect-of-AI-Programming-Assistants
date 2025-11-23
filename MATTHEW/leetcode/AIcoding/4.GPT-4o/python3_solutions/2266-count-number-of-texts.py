class Solution:
    def countTexts(self, pressedKeys: str) -> int:
        MOD = 10**9 + 7
        n = len(pressedKeys)
        dp = [0] * (n + 1)
        dp[0] = 1

        for i in range(1, n + 1):
            count = 1
            for j in range(i, 0, -1):
                if j < i and pressedKeys[j - 1] == pressedKeys[i - 1]:
                    count += 1
                if count > 4 or (pressedKeys[i - 1] in "79" and count > 3):
                    break
                dp[i] = (dp[i] + dp[j - 1]) % MOD

        return dp[n]