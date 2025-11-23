class Solution:
    def teleport(self, maze: List[List[int]], start: List[int], destination: List[int]) -> bool:
        m, n = len(maze), len(maze[0])
        visited = [[False for _ in range(n)] for _ in range(m)]
        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        queue = deque()
        queue.append((start[0], start[1]))
        visited[start[0]][start[1]] = True

        while queue:
            x, y = queue.popleft()
            if [x, y] == destination:
                return True
            for dx, dy in directions:
                nx, ny = x + dx, y + dy
                while 0 <= nx < m and 0 <= ny < n and maze[nx][ny] == 0:
                    nx += dx
                    ny += dy
                nx -= dx
                ny -= dy
                if not visited[nx][ny]:
                    visited[nx][ny] = True
                    queue.append((nx, ny))
        return False