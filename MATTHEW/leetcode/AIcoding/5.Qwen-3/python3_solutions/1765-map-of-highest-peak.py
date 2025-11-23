from collections import deque
import numpy as np

class Solution:
    def highestPeak(self, matrix: list[list[int]]) -> list[list[int]]:
        if not matrix or not matrix[0]:
            return []

        rows, cols = len(matrix), len(matrix[0])
        result = [[-1 for _ in range(cols)] for _ in range(rows)]
        queue = deque()

        for i in range(rows):
            for j in range(cols):
                if matrix[i][j] == 0:
                    result[i][j] = 0
                    queue.append((i, j))

        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]

        while queue:
            x, y = queue.popleft()
            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                if 0 <= nx < rows and 0 <= ny < cols and result[nx][ny] == -1:
                    result[nx][ny] = result[x][y] + 1
                    queue.append((nx, ny))

        return result