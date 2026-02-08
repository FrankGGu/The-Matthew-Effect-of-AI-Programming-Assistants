class Solution:
    def checkValidGrid(self, grid: List[List[int]]) -> bool:
        n = len(grid)
        if grid[0][0] != 0 or grid[n - 1][n - 1] != n * n - 1:
            return False

        directions = [(2, 1), (2, -1), (-2, 1), (-2, -1), (1, 2), (1, -2), (-1, 2), (-1, -2)]
        visited = set()
        visited.add((0, 0))

        for num in range(1, n * n):
            found = False
            for dx, dy in directions:
                x, y = divmod(num, n)
                nx, ny = x + dx, y + dy
                if 0 <= nx < n and 0 <= ny < n and (nx, ny) not in visited and grid[nx][ny] == num:
                    visited.add((nx, ny))
                    found = True
                    break
            if not found:
                return False

        return len(visited) == n * n