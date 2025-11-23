class Solution:
    def escapeMaze(self, maze: List[List[int]], start: List[int], end: List[int], k: int) -> bool:
        from collections import deque

        m, n = len(maze), len(maze[0])
        visited = [[[False] * (k + 1) for _ in range(n)] for _ in range(m)]
        queue = deque()
        queue.append((start[0], start[1], k))
        visited[start[0]][start[1]][k] = True

        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]

        while queue:
            x, y, remaining = queue.popleft()
            if [x, y] == end:
                return True
            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                if 0 <= nx < m and 0 <= ny < n and not visited[nx][ny][remaining]:
                    visited[nx][ny][remaining] = True
                    queue.append((nx, ny, remaining))
            if remaining > 0:
                for dx, dy in directions:
                    nx, ny = x + dx, y + dy
                    if 0 <= nx < m and 0 <= ny < n and not visited[nx][ny][remaining - 1]:
                        visited[nx][ny][remaining - 1] = True
                        queue.append((nx, ny, remaining - 1))
        return False