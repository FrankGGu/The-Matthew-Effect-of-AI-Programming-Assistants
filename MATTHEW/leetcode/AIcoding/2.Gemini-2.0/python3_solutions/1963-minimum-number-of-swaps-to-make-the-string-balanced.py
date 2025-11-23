class Solution:
    def minSwaps(self, s: str) -> int:
        open_brackets = 0
        for char in s:
            if char == '[':
                open_brackets += 1
            elif open_brackets > 0:
                open_brackets -= 1
        return (open_brackets + 1) // 2