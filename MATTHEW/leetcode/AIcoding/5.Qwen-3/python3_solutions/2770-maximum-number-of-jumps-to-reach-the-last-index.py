class Solution:
    def maxJumps(self, arr: List[int], time: int) -> int:
        n = len(arr)
        dp = [-1] * n
        dp[0] = 0

        for i in range(1, n):
            for j in range(i):
                if abs(arr[i] - arr[j]) <= time and dp[j] != -1:
                    dp[i] = max(dp[i], dp[j] + 1)

        return dp[-1]