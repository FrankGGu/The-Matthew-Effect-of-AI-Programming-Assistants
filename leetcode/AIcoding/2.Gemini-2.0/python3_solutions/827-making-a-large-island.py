class Solution:
    def largestIsland(self, grid: List[List[int]]) -> int:
        n = len(grid)
        def dfs(i, j, island_id):
            if i < 0 or i >= n or j < 0 or j >= n or grid[i][j] != 1:
                return 0
            grid[i][j] = island_id
            return 1 + dfs(i + 1, j, island_id) + dfs(i - 1, j, island_id) + dfs(i, j + 1, island_id) + dfs(i, j - 1, island_id)

        island_sizes = {}
        island_id = 2
        for i in range(n):
            for j in range(n):
                if grid[i][j] == 1:
                    island_sizes[island_id] = dfs(i, j, island_id)
                    island_id += 1

        max_island = 0
        for size in island_sizes.values():
            max_island = max(max_island, size)

        for i in range(n):
            for j in range(n):
                if grid[i][j] == 0:
                    neighbor_islands = set()
                    if i > 0 and grid[i - 1][j] > 1:
                        neighbor_islands.add(grid[i - 1][j])
                    if i < n - 1 and grid[i + 1][j] > 1:
                        neighbor_islands.add(grid[i + 1][j])
                    if j > 0 and grid[i][j - 1] > 1:
                        neighbor_islands.add(grid[i][j - 1])
                    if j < n - 1 and grid[i][j + 1] > 1:
                        neighbor_islands.add(grid[i][j + 1])

                    size = 1
                    for island in neighbor_islands:
                        size += island_sizes[island]
                    max_island = max(max_island, size)

        return max_island