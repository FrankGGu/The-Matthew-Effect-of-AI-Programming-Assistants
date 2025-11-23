class Solution:
    def minimumPartitions(self, s: str, k: int) -> int:
        max_digit = 0
        for c in s:
            digit = int(c)
            if digit > max_digit:
                max_digit = digit
        return max_digit