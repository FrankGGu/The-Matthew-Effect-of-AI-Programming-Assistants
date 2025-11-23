class Solution:
    def tallestBillboard(self, rods: List[int]) -> int:
        from collections import defaultdict

        def dfs(i, diff, memo):
            if i == len(rods):
                return 0 if diff == 0 else -float('inf')
            if (i, diff) in memo:
                return memo[(i, diff)]
            res = dfs(i + 1, diff, memo)
            res = max(res, dfs(i + 1, diff + rods[i], memo) + rods[i])
            res = max(res, dfs(i + 1, diff - rods[i], memo) + rods[i])
            memo[(i, diff)] = res
            return res

        return dfs(0, 0, {})