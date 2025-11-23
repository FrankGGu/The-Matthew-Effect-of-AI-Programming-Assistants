class Solution:
    def minOperations(self, A: List[int], target: int) -> int:
        from collections import defaultdict

        n = len(A)
        dp = defaultdict(lambda: float('inf'))
        dp[0] = 0

        for num in A:
            for t in list(dp.keys()):
                dp[t + num] = min(dp[t + num], dp[t] + 1)

        return dp[target] if dp[target] != float('inf') else -1