class Solution:
    def largestIsland(self, grid: List[List[int]]) -> int:
        from collections import defaultdict

        def dfs(i, j, index):
            if 0 <= i < len(grid) and 0 <= j < len(grid[0]) and grid[i][j] == 1:
                grid[i][j] = index
                for dx, dy in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                    dfs(i + dx, j + dy, index)

        def get_neighbors(i, j):
            neighbors = set()
            for dx, dy in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                ni, nj = i + dx, j + dy
                if 0 <= ni < len(grid) and 0 <= nj < len(grid[0]):
                    if grid[ni][nj] != 0:
                        neighbors.add(grid[ni][nj])
            return neighbors

        index = 2
        area = defaultdict(int)
        for i in range(len(grid)):
            for j in range(len(grid[0])):
                if grid[i][j] == 1:
                    dfs(i, j, index)
                    area[index] += 1
                    index += 1

        max_area = max(area.values()) if area else 0
        for i in range(len(grid)):
            for j in range(len(grid[0])):
                if grid[i][j] == 0:
                    neighbors = get_neighbors(i, j)
                    total = 1
                    for neighbor in neighbors:
                        total += area[neighbor]
                    max_area = max(max_area, total)

        return max_area