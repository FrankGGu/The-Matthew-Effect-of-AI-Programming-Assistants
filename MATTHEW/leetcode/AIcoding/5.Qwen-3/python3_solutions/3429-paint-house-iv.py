class Solution:
    def minCost(self, costs: List[List[int]]) -> int:
        if not costs:
            return 0
        n = len(costs)
        k = len(costs[0])
        for i in range(1, n):
            for j in range(k):
                min_prev = float('inf')
                for m in range(k):
                    if m != j:
                        min_prev = min(min_prev, costs[i-1][m])
                costs[i][j] += min_prev
        return min(costs[-1])