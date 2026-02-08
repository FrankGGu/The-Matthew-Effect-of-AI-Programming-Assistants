class Solution:
    def minDays(self, n: int) -> int:
        memo = {}

        def dfs(k):
            if k <= 1:
                return k
            if k in memo:
                return memo[k]

            res_option_2 = (k % 2) + 1 + dfs(k // 2)
            res_option_3 = (k % 3) + 1 + dfs(k // 3)

            memo[k] = min(res_option_2, res_option_3)
            return memo[k]

        return dfs(n)