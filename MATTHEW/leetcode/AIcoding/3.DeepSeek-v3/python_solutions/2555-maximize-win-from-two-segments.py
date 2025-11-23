class Solution:
    def maximizeWin(self, prizePositions: List[int], k: int) -> int:
        n = len(prizePositions)
        if n == 0:
            return 0

        left = 0
        dp = [0] * (n + 1)
        res = 0

        for right in range(n):
            while prizePositions[right] - prizePositions[left] > k:
                left += 1
            current_win = right - left + 1
            dp[right + 1] = max(dp[right], current_win)
            res = max(res, current_win + dp[left])

        return res