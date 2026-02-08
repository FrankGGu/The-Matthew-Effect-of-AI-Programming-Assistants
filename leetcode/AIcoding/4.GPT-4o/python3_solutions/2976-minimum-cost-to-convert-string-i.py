class Solution:
    def minimumCost(self, s: str, cost: List[int]) -> int:
        total_cost = 0
        max_cost = 0

        for i in range(len(s)):
            if i > 0 and s[i] == s[i - 1]:
                total_cost += min(cost[i], cost[i - 1])
                max_cost = max(max_cost, max(cost[i], cost[i - 1]))
            else:
                max_cost = 0

        return total_cost