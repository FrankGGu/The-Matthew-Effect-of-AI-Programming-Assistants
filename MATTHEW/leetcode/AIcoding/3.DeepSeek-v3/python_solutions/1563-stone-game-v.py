class Solution:
    def stoneGameV(self, stoneValue: List[int]) -> int:
        n = len(stoneValue)
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i+1] = prefix[i] + stoneValue[i]

        memo = [[0] * n for _ in range(n)]

        def dfs(l, r):
            if l == r:
                return 0
            if memo[l][r] != 0:
                return memo[l][r]

            res = 0
            for k in range(l, r):
                left_sum = prefix[k+1] - prefix[l]
                right_sum = prefix[r+1] - prefix[k+1]
                if left_sum < right_sum:
                    res = max(res, left_sum + dfs(l, k))
                elif left_sum > right_sum:
                    res = max(res, right_sum + dfs(k+1, r))
                else:
                    res = max(res, left_sum + max(dfs(l, k), dfs(k+1, r)))
            memo[l][r] = res
            return res

        return dfs(0, n-1)