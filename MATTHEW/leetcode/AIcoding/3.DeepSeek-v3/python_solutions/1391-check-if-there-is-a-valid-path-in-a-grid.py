class Solution:
    def hasValidPath(self, grid: List[List[int]]) -> bool:
        if not grid or not grid[0]:
            return False

        m, n = len(grid), len(grid[0])
        directions = {
            1: [(0, -1), (0, 1)],
            2: [(-1, 0), (1, 0)],
            3: [(0, -1), (1, 0)],
            4: [(0, 1), (1, 0)],
            5: [(0, -1), (-1, 0)],
            6: [(0, 1), (-1, 0)]
        }

        visited = [[False for _ in range(n)] for _ in range(m)]
        queue = deque()
        queue.append((0, 0))
        visited[0][0] = True

        while queue:
            x, y = queue.popleft()
            if x == m - 1 and y == n - 1:
                return True
            for dx, dy in directions[grid[x][y]]:
                nx, ny = x + dx, y + dy
                if 0 <= nx < m and 0 <= ny < n and not visited[nx][ny]:
                    for back_dx, back_dy in directions[grid[nx][ny]]:
                        if nx + back_dx == x and ny + back_dy == y:
                            visited[nx][ny] = True
                            queue.append((nx, ny))
                            break
        return False