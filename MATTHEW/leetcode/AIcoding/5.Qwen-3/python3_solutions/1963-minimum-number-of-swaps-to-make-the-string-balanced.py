class Solution:
    def minSwaps(self, s: str) -> int:
        swaps = 0
        open_count = 0
        for char in s:
            if char == '[':
                open_count += 1
            else:
                open_count -= 1
            if open_count < 0:
                swaps += 1
                open_count += 2
        return swaps