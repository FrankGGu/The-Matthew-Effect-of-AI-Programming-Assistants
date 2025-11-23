from collections import deque

class Solution:
    def shortestBridge(self, grid: List[List[int]]) -> int:
        n = len(grid)
        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        queue = deque()
        found = False

        # DFS to find the first island and mark its cells
        for i in range(n):
            if found:
                break
            for j in range(n):
                if grid[i][j] == 1:
                    self.dfs(grid, i, j, queue)
                    found = True
                    break

        # BFS to expand the first island until reaching the second island
        steps = 0
        while queue:
            size = len(queue)
            for _ in range(size):
                x, y = queue.popleft()
                for dx, dy in directions:
                    nx, ny = x + dx, y + dy
                    if 0 <= nx < n and 0 <= ny < n:
                        if grid[nx][ny] == 1:
                            return steps
                        elif grid[nx][ny] == 0:
                            grid[nx][ny] = 2
                            queue.append((nx, ny))
            steps += 1
        return -1

    def dfs(self, grid, i, j, queue):
        n = len(grid)
        if i < 0 or i >= n or j < 0 or j >= n or grid[i][j] != 1:
            return
        grid[i][j] = 2
        queue.append((i, j))
        self.dfs(grid, i + 1, j, queue)
        self.dfs(grid, i - 1, j, queue)
        self.dfs(grid, i, j + 1, queue)
        self.dfs(grid, i, j - 1, queue)