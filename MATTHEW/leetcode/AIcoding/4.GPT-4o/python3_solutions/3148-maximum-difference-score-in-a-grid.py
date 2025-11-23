class Solution:
    def maxDifference(self, grid: List[List[int]]) -> int:
        max_row = max(map(max, grid))
        min_row = min(map(min, grid))
        return max_row - min_row