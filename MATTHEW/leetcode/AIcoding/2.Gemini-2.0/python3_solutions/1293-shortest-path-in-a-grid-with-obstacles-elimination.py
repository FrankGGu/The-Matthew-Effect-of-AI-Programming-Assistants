from collections import deque

class Solution:
    def shortestPath(self, grid: list[list[int]], k: int) -> int:
        m, n = len(grid), len(grid[0])
        if k >= m + n - 2:
            return m + n - 2

        visited = set()
        queue = deque([(0, 0, k, 0)]) 

        while queue:
            row, col, remaining_k, steps = queue.popleft()

            if row == m - 1 and col == n - 1:
                return steps

            if (row, col, remaining_k) in visited:
                continue
            visited.add((row, col, remaining_k))

            directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

            for dr, dc in directions:
                new_row, new_col = row + dr, col + dc

                if 0 <= new_row < m and 0 <= new_col < n:
                    if grid[new_row][new_col] == 0:
                        queue.append((new_row, new_col, remaining_k, steps + 1))
                    elif remaining_k > 0:
                        queue.append((new_row, new_col, remaining_k - 1, steps + 1))

        return -1