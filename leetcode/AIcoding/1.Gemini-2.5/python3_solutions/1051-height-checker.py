class Solution:
    def heightChecker(self, heights: list[int]) -> int:
        expected = sorted(heights)
        mismatches = 0
        for i in range(len(heights)):
            if heights[i] != expected[i]:
                mismatches += 1
        return mismatches