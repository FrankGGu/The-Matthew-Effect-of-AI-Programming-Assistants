class Solution:
    def minAddToMakeValid(self, s: str) -> int:
        left_needed = 0
        right_needed = 0

        for char in s:
            if char == '(':
                right_needed += 1
            else:
                if right_needed > 0:
                    right_needed -= 1
                else:
                    left_needed += 1

        return left_needed + right_needed