from collections import deque

class Solution:
    def largestIsland(self, grid: List[List[int]]) -> int:
        rows = len(grid)
        cols = len(grid[0])

        island_sizes = {} # Stores {island_id: size}
        current_island_id = 2 # 0 for water, 1 for initial land, so start IDs from 2

        # DFS function to find island size and mark cells with island_id
        def dfs(r, c, island_id):
            if not (0 <= r < rows and 0 <= c < cols and grid[r][c] == 1):
                return 0

            grid[r][c] = island_id # Mark cell with its island ID
            size = 1
            size += dfs(r + 1, c, island_id)
            size += dfs(r - 1, c, island_id)
            size += dfs(r, c + 1, island_id)
            size += dfs(r, c - 1, island_id)
            return size

        # First pass: Find all existing islands and their sizes
        for r in range(rows):
            for c in range(cols):
                if grid[r][c] == 1:
                    size = dfs(r, c, current_island_id)
                    island_sizes[current_island_id] = size
                    current_island_id += 1

        # Initialize max_island_size
        # If there are no existing islands (all 0s), max_island_size will be 0 initially,
        # and then updated to 1 in the second pass.
        # If the grid is all 1s, max_island_size will be rows * cols from this initialization.
        max_island_size = 0
        if island_sizes:
            max_island_size = max(island_sizes.values())

        # Second pass: Try flipping each '0' to '1'
        for r in range(rows):
            for c in range(cols):
                if grid[r][c] == 0:
                    potential_size = 1 # The '0' itself

                    # Collect unique adjacent island IDs
                    adjacent_islands = set()

                    for dr, dc in [(0, 1), (0, -1), (1, 0), (-1, 0)]:
                        nr, nc = r + dr, c + dc
                        if 0 <= nr < rows and 0 <= nc < cols and grid[nr][nc] > 1: # It's an existing island
                            adjacent_islands.add(grid[nr][nc])

                    # Sum sizes of unique adjacent islands
                    for island_id in adjacent_islands:
                        potential_size += island_sizes[island_id]

                    max_island_size = max(max_island_size, potential_size)

        return max_island_size