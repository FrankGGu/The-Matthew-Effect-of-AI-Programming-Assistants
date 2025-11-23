class Solution:
    def maximumGood(self, s: str) -> int:
        max_sum = 0
        current_sum = 0
        for c in s:
            if c == 'G':
                current_sum += 1
            else:
                current_sum = 0
            max_sum = max(max_sum, current_sum)
        return max_sum