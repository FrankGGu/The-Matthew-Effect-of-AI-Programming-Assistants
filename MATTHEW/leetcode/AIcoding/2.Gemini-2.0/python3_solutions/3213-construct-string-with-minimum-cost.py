class Solution:
    def minCost(self, s: str, cost: list[int]) -> int:
        res = 0
        i = 0
        while i < len(s) - 1:
            j = i
            max_cost = 0
            total_cost = 0
            while j < len(s) and s[i] == s[j]:
                max_cost = max(max_cost, cost[j])
                total_cost += cost[j]
                j += 1
            res += total_cost - max_cost
            i = j
        return res