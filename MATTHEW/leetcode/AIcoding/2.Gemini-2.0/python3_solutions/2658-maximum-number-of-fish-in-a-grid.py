class Solution:
    def findMaxFish(self, grid: List[List[int]]) -> int:
        rows, cols = len(grid), len(grid[0])
        visited = set()
        max_fish = 0

        def dfs(row, col):
            if (row, col) in visited or not (0 <= row < rows and 0 <= col < cols) or grid[row][col] == 0:
                return 0

            visited.add((row, col))
            fish = grid[row][col]

            fish += dfs(row + 1, col)
            fish += dfs(row - 1, col)
            fish += dfs(row, col + 1)
            fish += dfs(row, col - 1)

            return fish

        for row in range(rows):
            for col in range(cols):
                if grid[row][col] > 0 and (row, col) not in visited:
                    max_fish = max(max_fish, dfs(row, col))

        return max_fish