from collections import deque
from typing import List

class Solution:
    def highestPeak(self, isWater: List[List[int]]) -> List[List[int]]:
        m, n = len(isWater), len(isWater[0])
        heights = [[-1] * n for _ in range(m)]
        queue = deque()
        for i in range(m):
            for j in range(n):
                if isWater[i][j] == 1:
                    heights[i][j] = 0
                    queue.append((i, j))

        directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

        while queue:
            row, col = queue.popleft()
            for dr, dc in directions:
                new_row, new_col = row + dr, col + dc
                if 0 <= new_row < m and 0 <= new_col < n and heights[new_row][new_col] == -1:
                    heights[new_row][new_col] = heights[row][col] + 1
                    queue.append((new_row, new_col))

        return heights