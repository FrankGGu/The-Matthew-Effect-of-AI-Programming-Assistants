class Solution:
    def maxCost(self, s: str, cost: list[int]) -> int:
        max_cost = 0
        current_cost = 0
        prev_char = ''

        for i in range(len(s)):
            if s[i] == prev_char:
                current_cost += cost[i]
            else:
                current_cost = cost[i]
                prev_char = s[i]

            max_cost = max(max_cost, current_cost)

        return max_cost