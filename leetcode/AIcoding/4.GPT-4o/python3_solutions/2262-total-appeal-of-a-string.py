class Solution:
    def appealSum(self, s: str) -> int:
        total_appeal = 0
        last_index = {}
        n = len(s)

        for i in range(n):
            char = s[i]
            last_index[char] = i
            total_appeal += (i + 1) * (1 + (last_index[char] - (last_index[char] - 1) if char in last_index else 0))

        return total_appeal