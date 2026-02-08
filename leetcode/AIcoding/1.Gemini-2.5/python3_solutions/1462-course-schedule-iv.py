from typing import List

class Solution:
    def checkIfPrerequisite(self, n: int, prerequisites: List[List[int]], queries: List[List[int]]) -> List[bool]:
        dp = [[False] * n for _ in range(n)]

        for u, v in prerequisites:
            dp[u][v] = True

        for k in range(n):
            for i in range(n):
                for j in range(n):
                    dp[i][j] = dp[i][j] or (dp[i][k] and dp[k][j])

        results = []
        for u, v in queries:
            results.append(dp[u][v])

        return results