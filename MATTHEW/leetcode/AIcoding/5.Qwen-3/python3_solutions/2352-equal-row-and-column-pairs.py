from collections import defaultdict
from typing import List

class Solution:
    def equalPairs(self, grid: List[List[int]]) -> int:
        count = defaultdict(int)
        n = len(grid)
        for i in range(n):
            row = tuple(grid[i])
            count[row] += 1
        result = 0
        for j in range(n):
            col = tuple(grid[i][j] for i in range(n))
            result += count.get(col, 0)
        return result