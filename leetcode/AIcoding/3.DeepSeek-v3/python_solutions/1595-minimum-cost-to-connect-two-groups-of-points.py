class Solution:
    def connectTwoGroups(self, cost: List[List[int]]) -> int:
        size1, size2 = len(cost), len(cost[0])
        min_cost2 = [min(cost[i][j] for i in range(size1)) for j in range(size2)]

        @lru_cache(None)
        def dfs(i, mask):
            if i == size1:
                res = 0
                for j in range(size2):
                    if not (mask & (1 << j)):
                        res += min_cost2[j]
                return res
            res = float('inf')
            for j in range(size2):
                res = min(res, cost[i][j] + dfs(i + 1, mask | (1 << j)))
            return res

        return dfs(0, 0)