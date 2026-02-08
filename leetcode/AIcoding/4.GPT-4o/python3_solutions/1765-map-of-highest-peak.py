from collections import deque

class Solution:
    def highestPeak(self, isWater: List[List[int]]) -> List[List[int]]:
        rows, cols = len(isWater), len(isWater[0])
        result = [[-1] * cols for _ in range(rows)]
        queue = deque()

        for r in range(rows):
            for c in range(cols):
                if isWater[r][c] == 1:
                    result[r][c] = 0
                    queue.append((r, c))

        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]

        while queue:
            r, c = queue.popleft()
            for dr, dc in directions:
                nr, nc = r + dr, c + dc
                if 0 <= nr < rows and 0 <= nc < cols and result[nr][nc] == -1:
                    result[nr][nc] = result[r][c] + 1
                    queue.append((nr, nc))

        return result