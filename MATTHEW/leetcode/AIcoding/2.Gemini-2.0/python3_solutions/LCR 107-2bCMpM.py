from collections import deque

class Solution:
    def updateMatrix(self, matrix: List[List[int]]) -> List[List[int]]:
        m, n = len(matrix), len(matrix[0])
        dist = [[float('inf')] * n for _ in range(m)]
        queue = deque()
        for i in range(m):
            for j in range(n):
                if matrix[i][j] == 0:
                    dist[i][j] = 0
                    queue.append((i, j))

        directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]
        while queue:
            i, j = queue.popleft()
            for dx, dy in directions:
                x, y = i + dx, j + dy
                if 0 <= x < m and 0 <= y < n and dist[x][y] > dist[i][j] + 1:
                    dist[x][y] = dist[i][j] + 1
                    queue.append((x, y))

        return dist