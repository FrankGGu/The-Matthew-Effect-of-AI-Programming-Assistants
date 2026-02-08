class Solution:
    def soupServings(self, N: int) -> float:
        if N > 5000:
            return 1.0
        memo = {}

        def dfs(a, b):
            if a <= 0 and b <= 0:
                return 0.5
            if a <= 0:
                return 1.0
            if b <= 0:
                return 0.0
            if (a, b) in memo:
                return memo[(a, b)]

            result = (dfs(a - 100, b) + dfs(a - 75, b - 25) +
                      dfs(a - 50, b - 50) + dfs(a - 25, b - 75)) / 4
            memo[(a, b)] = result
            return result

        return dfs(N, N)