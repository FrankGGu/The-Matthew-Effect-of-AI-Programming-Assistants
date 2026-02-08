from collections import deque

class Solution:
    def shortestBridge(self, grid):
        def dfs(i, j):
            if 0 <= i < len(grid) and 0 <= j < len(grid[0]) and grid[i][j] == 1:
                grid[i][j] = -1
                island.append((i, j))
                dfs(i + 1, j)
                dfs(i - 1, j)
                dfs(i, j + 1)
                dfs(i, j - 1)

        def bfs():
            while queue:
                x, y, dist = queue.popleft()
                if grid[x][y] == 1:
                    return dist - 1
                for dx, dy in directions:
                    nx, ny = x + dx, y + dy
                    if 0 <= nx < len(grid) and 0 <= ny < len(grid[0]) and grid[nx][ny] != -1:
                        grid[nx][ny] = -1
                        queue.append((nx, ny, dist + 1))

        island = []
        found = False
        for i in range(len(grid)):
            for j in range(len(grid[0])):
                if grid[i][j] == 1:
                    dfs(i, j)
                    found = True
                    break
            if found:
                break

        queue = deque([(x, y, 1) for x, y in island])
        directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]
        return bfs()