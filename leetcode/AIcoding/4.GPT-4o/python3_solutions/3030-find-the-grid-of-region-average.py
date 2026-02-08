class Solution:
    def findRegionAverage(self, grid: List[List[int]], r: int, c: int) -> float:
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        total = 0
        count = 0
        rows, cols = len(grid), len(grid[0])

        def in_bounds(x, y):
            return 0 <= x < rows and 0 <= y < cols

        for dx, dy in directions:
            x, y = r + dx, c + dy
            if in_bounds(x, y):
                total += grid[x][y]
                count += 1

        return total / count if count > 0 else 0.0