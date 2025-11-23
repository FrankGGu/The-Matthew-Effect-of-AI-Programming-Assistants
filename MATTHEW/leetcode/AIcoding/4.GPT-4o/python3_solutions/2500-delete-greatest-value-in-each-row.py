class Solution:
    def deleteGreatestValue(self, grid: List[List[int]]) -> int:
        return sum(max(row) for row in grid)