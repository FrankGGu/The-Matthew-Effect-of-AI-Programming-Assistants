class Solution:
    def uniquePathsIII(self, grid: list[list[int]]) -> int:
        R, C = len(grid), len(grid[0])

        start_r, start_c = -1, -1
        total_empty_cells = 0

        for r in range(R):
            for c in range(C):
                if grid[r][c] == 1:
                    start_r, start_c = r, c
                elif grid[r][c] == 0:
                    total_empty_cells += 1

        self.paths_count = 0

        def dfs(r, c, current_empty_visited_count):
            if not (0 <= r < R and 0 <= c < C) or grid[r][c] == -1:
                return

            if grid[r][c] == 2:
                if current_empty_visited_count == total_empty_cells:
                    self.paths_count += 1
                return

            temp = grid[r][c]
            grid[r][c] = -1 

            new_empty_visited_count = current_empty_visited_count
            if temp == 0:
                new_empty_visited_count += 1

            directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]
            for dr, dc in directions:
                dfs(r + dr, c + dc, new_empty_visited_count)

            grid[r][c] = temp

        dfs(start_r, start_c, 0)

        return self.paths_count