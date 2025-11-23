class Solution:
    def uniquePathsIII(self, grid: List[List[int]]) -> int:
        self.total_empty = 0
        self.start = (0, 0)
        self.end = (0, 0)

        for r in range(len(grid)):
            for c in range(len(grid[0])):
                if grid[r][c] == 0:
                    self.total_empty += 1
                elif grid[r][c] == 1:
                    self.start = (r, c)
                elif grid[r][c] == 2:
                    self.end = (r, c)

        def backtrack(r, c, empty_count):
            if (r, c) == self.end:
                return 1 if empty_count == 0 else 0

            total_paths = 0
            grid[r][c] = -1

            for dr, dc in [(0, 1), (1, 0), (0, -1), (-1, 0)]:
                new_r, new_c = r + dr, c + dc
                if 0 <= new_r < len(grid) and 0 <= new_c < len(grid[0]) and grid[new_r][new_c] != -1:
                    total_paths += backtrack(new_r, new_c, empty_count - (grid[new_r][new_c] == 0))

            grid[r][c] = 0
            return total_paths

        return backtrack(self.start[0], self.start[1], self.total_empty)