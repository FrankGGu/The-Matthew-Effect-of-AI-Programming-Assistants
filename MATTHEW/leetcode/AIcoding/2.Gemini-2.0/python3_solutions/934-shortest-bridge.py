from collections import deque

class Solution:
    def shortestBridge(self, grid: list[list[int]]) -> int:
        n = len(grid)
        visited = set()

        def dfs(i, j):
            if i < 0 or i >= n or j < 0 or j >= n or (i, j) in visited or grid[i][j] == 0:
                return
            visited.add((i, j))
            dfs(i + 1, j)
            dfs(i - 1, j)
            dfs(i, j + 1)
            dfs(i, j - 1)

        def find_first_island():
            for i in range(n):
                for j in range(n):
                    if grid[i][j] == 1:
                        return i, j
            return None

        start_i, start_j = find_first_island()
        dfs(start_i, start_j)

        queue = deque(visited)
        distance = 0

        while queue:
            size = len(queue)
            for _ in range(size):
                i, j = queue.popleft()
                for di, dj in [(0, 1), (0, -1), (1, 0), (-1, 0)]:
                    new_i, new_j = i + di, j + dj
                    if 0 <= new_i < n and 0 <= new_j < n and (new_i, new_j) not in visited:
                        if grid[new_i][new_j] == 1:
                            return distance
                        queue.append((new_i, new_j))
                        visited.add((new_i, new_j))
            distance += 1

        return -1