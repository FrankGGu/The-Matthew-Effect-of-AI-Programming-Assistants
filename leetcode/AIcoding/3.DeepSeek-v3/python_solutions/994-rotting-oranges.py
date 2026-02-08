from collections import deque

class Solution:
    def orangesRotting(self, grid: List[List[int]]) -> int:
        rows = len(grid)
        if rows == 0:
            return -1
        cols = len(grid[0])

        fresh = 0
        rotten = deque()

        for r in range(rows):
            for c in range(cols):
                if grid[r][c] == 2:
                    rotten.append((r, c))
                elif grid[r][c] == 1:
                    fresh += 1

        minutes = 0
        directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]

        while rotten and fresh > 0:
            minutes += 1
            for _ in range(len(rotten)):
                x, y = rotten.popleft()
                for dx, dy in directions:
                    nx, ny = x + dx, y + dy
                    if 0 <= nx < rows and 0 <= ny < cols and grid[nx][ny] == 1:
                        grid[nx][ny] = 2
                        fresh -= 1
                        rotten.append((nx, ny))

        return minutes if fresh == 0 else -1