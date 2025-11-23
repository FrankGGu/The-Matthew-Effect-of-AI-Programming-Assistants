class Solution:
    def minCost(self, s: str, cost: List[int]) -> int:
        n = len(s)
        total_cost = 0
        max_cost = 0

        for i in range(n // 2):
            left = cost[i]
            right = cost[n - 1 - i]
            total_cost += min(left, right)
            max_cost = max(max_cost, left + right)

        return total_cost