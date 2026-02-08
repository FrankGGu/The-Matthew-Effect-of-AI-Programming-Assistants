class Solution:
    def maximizeWin(self, prizes: List[int], k: int) -> int:
        n = len(prizes)
        prizes.sort()

        left = 0
        max_wins = 0
        dp = [0] * (n + 1)

        for right in range(n):
            while prizes[right] - prizes[left] > k:
                left += 1
            dp[right + 1] = right - left + 1

        for i in range(1, n + 1):
            dp[i] = max(dp[i], dp[i - 1])

        for right in range(n):
            max_wins = max(max_wins, dp[right + 1] + dp[n] - dp[right + 1])

        return max_wins