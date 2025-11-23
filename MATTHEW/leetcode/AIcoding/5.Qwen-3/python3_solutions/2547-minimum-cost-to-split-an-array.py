class Solution:
    def minCost(self, arr: List[int], k: int) -> int:
        n = len(arr)
        dp = [float('inf')] * n
        dp[0] = 0
        for i in range(1, n):
            unique = set()
            cost = 0
            for j in range(i, max(-1, i - k), -1):
                unique.add(arr[j])
                cost += len(unique) == 1 or 0
                if j > 0:
                    dp[i] = min(dp[i], dp[j - 1] + cost)
                else:
                    dp[i] = min(dp[i], cost)
        return dp[-1]