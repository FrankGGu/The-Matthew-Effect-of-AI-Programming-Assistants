class Solution:
    def conveyorBelt(self, matrix: List[str], start: List[int], end: List[int]) -> int:
        from collections import deque
        m, n = len(matrix), len(matrix[0])
        directions = {'^': (-1, 0), 'v': (1, 0), '<': (0, -1), '>': (0, 1)}
        q = deque()
        q.append((start[0], start[1]))
        visited = [[float('inf')] * n for _ in range(m)]
        visited[start[0]][start[1]] = 0

        while q:
            x, y = q.popleft()
            if x == end[0] and y == end[1]:
                return visited[x][y]
            for d in directions.values():
                nx, ny = x + d[0], y + d[1]
                if 0 <= nx < m and 0 <= ny < n:
                    cost = visited[x][y] + (0 if (d[0], d[1]) == directions[matrix[x][y]] else 1)
                    if cost < visited[nx][ny]:
                        visited[nx][ny] = cost
                        if cost == visited[x][y]:
                            q.appendleft((nx, ny))
                        else:
                            q.append((nx, ny))
        return -1