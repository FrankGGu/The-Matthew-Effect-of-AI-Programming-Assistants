class Solution:
    def minimumCost(self, s: str, cost: List[int]) -> int:
        total_cost = 0
        max_cost = 0
        n = len(s)

        for i in range(n):
            if i > 0 and s[i] == s[i - 1]:
                total_cost += min(max_cost, cost[i])
                max_cost = max(max_cost, cost[i])
            else:
                total_cost += max_cost
                max_cost = cost[i]

        total_cost += max_cost
        return total_cost