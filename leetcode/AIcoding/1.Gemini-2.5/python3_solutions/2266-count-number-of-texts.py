class Solution:
    def countTexts(self, pressedKeys: str) -> int:
        MOD = 10**9 + 7
        n = len(pressedKeys)

        dp = [0] * (n + 1)
        dp[0] = 1

        for i in range(1, n + 1):
            # Option 1: The last digit forms a single character
            # e.g., "abc" -> "ab" + "c"
            dp[i] = dp[i-1]

            # Option 2: The last two identical digits form a single character
            # e.g., "abcc" -> "ab" + "cc" (where "cc" is one character)
            if i >= 2 and pressedKeys[i-1] == pressedKeys[i-2]:
                dp[i] = (dp[i] + dp[i-2]) % MOD

            # Option 3: The last three identical digits form a single character
            # e.g., "abccc" -> "ab" + "ccc" (where "ccc" is one character)
            if i >= 3 and pressedKeys[i-1] == pressedKeys[i-2] and pressedKeys[i-2] == pressedKeys[i-3]:
                dp[i] = (dp[i] + dp[i-3]) % MOD

            # Option 4: The last four identical digits form a single character
            # This is only possible for digits '7' and '9'
            if i >= 4 and pressedKeys[i-1] == pressedKeys[i-2] and \
               pressedKeys[i-2] == pressedKeys[i-3] and pressedKeys[i-3] == pressedKeys[i-4] and \
               (pressedKeys[i-1] == '7' or pressedKeys[i-1] == '9'):
                dp[i] = (dp[i] + dp[i-4]) % MOD

        return dp[n]