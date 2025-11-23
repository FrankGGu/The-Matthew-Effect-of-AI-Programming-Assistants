class Solution:
    def pacificAtlantic(self, heights: List[List[int]]) -> List[List[int]]:
        if not heights or not heights[0]:
            return []

        m, n = len(heights), len(heights[0])
        pacific = [[False for _ in range(n)] for _ in range(m)]
        atlantic = [[False for _ in range(n)] for _ in range(m)]

        from collections import deque

        def bfs(queue, visited):
            directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
            while queue:
                x, y = queue.popleft()
                for dx, dy in directions:
                    nx, ny = x + dx, y + dy
                    if 0 <= nx < m and 0 <= ny < n and not visited[nx][ny] and heights[nx][ny] >= heights[x][y]:
                        visited[nx][ny] = True
                        queue.append((nx, ny))

        pacific_queue = deque()
        atlantic_queue = deque()

        for i in range(m):
            pacific_queue.append((i, 0))
            pacific[i][0] = True
            atlantic_queue.append((i, n - 1))
            atlantic[i][n - 1] = True

        for j in range(n):
            pacific_queue.append((0, j))
            pacific[0][j] = True
            atlantic_queue.append((m - 1, j))
            atlantic[m - 1][j] = True

        bfs(pacific_queue, pacific)
        bfs(atlantic_queue, atlantic)

        result = []
        for i in range(m):
            for j in range(n):
                if pacific[i][j] and atlantic[i][j]:
                    result.append([i, j])

        return result