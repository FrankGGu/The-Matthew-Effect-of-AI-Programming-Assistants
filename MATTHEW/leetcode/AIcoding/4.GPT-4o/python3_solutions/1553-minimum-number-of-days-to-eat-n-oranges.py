class Solution:
    def minDays(self, n: int) -> int:
        memo = {}

        def dfs(n):
            if n <= 0:
                return 0
            if n in memo:
                return memo[n]
            memo[n] = 1 + min(n % 2 + dfs(n // 2), n % 3 + dfs(n // 3))
            return memo[n]

        return dfs(n)