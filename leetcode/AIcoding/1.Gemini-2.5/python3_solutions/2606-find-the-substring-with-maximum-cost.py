class Solution:
    def maximumCostSubstring(self, s: str, chars: str, vals: list[int]) -> int:
        char_costs = {}
        for i in range(len(chars)):
            char_costs[chars[i]] = vals[i]

        current_max = 0
        global_max = 0

        for char_s in s:
            cost = char_costs.get(char_s)
            if cost is None:
                cost = ord(char_s) - ord('a') + 1

            current_max = max(cost, current_max + cost)
            global_max = max(global_max, current_max)

        return global_max