class Solution:
    def maximumCostSubstring(self, s: str, chars: str, vals: List[int]) -> int:
        cost_map = {c: v for c, v in zip(chars, vals)}
        total_cost = 0
        max_cost = 0

        for char in s:
            total_cost += cost_map.get(char, -1)
            if total_cost < 0:
                total_cost = 0
            max_cost = max(max_cost, total_cost)

        return max_cost