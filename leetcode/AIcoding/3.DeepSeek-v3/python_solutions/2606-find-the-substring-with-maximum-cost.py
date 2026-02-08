class Solution:
    def maximumCostSubstring(self, s: str, chars: str, vals: List[int]) -> int:
        char_to_val = {}
        for c, v in zip(chars, vals):
            char_to_val[c] = v

        max_cost = 0
        current_cost = 0

        for c in s:
            if c in char_to_val:
                current_cost += char_to_val[c]
            else:
                current_cost += (ord(c) - ord('a') + 1)

            if current_cost > max_cost:
                max_cost = current_cost

            if current_cost < 0:
                current_cost = 0

        return max_cost