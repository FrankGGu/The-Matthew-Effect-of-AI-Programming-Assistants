class Solution:
    def findColumnWidth(self, grid: List[List[str]]) -> List[int]:
        return [max(len(cell) for cell in column) for column in zip(*grid)]