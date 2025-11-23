class Solution:
    def stoneGameIII(self, stoneGame: List[int]) -> str:
        n = len(stoneGame)
        dp = [0] * (n + 1)

        for i in range(n - 1, -1, -1):
            dp[i] = float('inf')
            for j in range(1, 4):
                if i + j <= n:
                    dp[i] = min(dp[i], dp[i + j] - stoneGame[i])

        if dp[0] > 0:
            return "Alice"
        elif dp[0] < 0:
            return "Bob"
        else:
            return "Tie"