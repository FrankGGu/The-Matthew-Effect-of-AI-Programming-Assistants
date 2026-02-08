class Solution:
    def constructGrid(self, rows: int, cols: int) -> List[List[int]]:
        return [[i * cols + j for j in range(cols)] for i in range(rows)]