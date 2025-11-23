class Solution:
    def minimumCost(self, s: str, cost: List[int]) -> int:
        total_cost = 0
        max_cost = 0
        current_cost = 0

        for i in range(len(s)):
            if i > 0 and s[i] == s[i - 1]:
                current_cost += cost[i]
                max_cost = max(max_cost, cost[i - 1])
            else:
                total_cost += current_cost - max_cost
                current_cost = cost[i]
                max_cost = cost[i]

        total_cost += current_cost - max_cost
        return total_cost