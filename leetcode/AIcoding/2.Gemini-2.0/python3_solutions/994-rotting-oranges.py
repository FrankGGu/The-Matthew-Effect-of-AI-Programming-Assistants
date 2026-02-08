from collections import deque

class Solution:
    def orangesRotting(self, grid: list[list[int]]) -> int:
        rows, cols = len(grid), len(grid[0])
        fresh_oranges = 0
        rotten_oranges = deque()

        for r in range(rows):
            for c in range(cols):
                if grid[r][c] == 1:
                    fresh_oranges += 1
                elif grid[r][c] == 2:
                    rotten_oranges.append((r, c))

        minutes = 0
        directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

        while rotten_oranges and fresh_oranges > 0:
            minutes += 1
            for _ in range(len(rotten_oranges)):
                r, c = rotten_oranges.popleft()

                for dr, dc in directions:
                    new_r, new_c = r + dr, c + dc

                    if 0 <= new_r < rows and 0 <= new_c < cols and grid[new_r][new_c] == 1:
                        grid[new_r][new_c] = 2
                        fresh_oranges -= 1
                        rotten_oranges.append((new_r, new_c))

        return minutes if fresh_oranges == 0 else -1