import collections

class Solution:
    def shortestPath(self, grid: list[list[int]], k: int) -> int:
        m, n = len(grid), len(grid[0])

        if m == 1 and n == 1:
            return 0

        if k >= m + n - 2:
            return m + n - 2

        queue = collections.deque([(0, 0, 0, 0)])  # (row, col, obstacles_eliminated_so_far, steps)
        visited = set([(0, 0, 0)])  # (row, col, obstacles_eliminated_so_far)

        directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

        while queue:
            r, c, current_k_eliminated, steps = queue.popleft()

            for dr, dc in directions:
                nr, nc = r + dr, c + dc

                if 0 <= nr < m and 0 <= nc < n:
                    new_k_eliminated = current_k_eliminated

                    if grid[nr][nc] == 1:
                        new_k_eliminated += 1

                    if new_k_eliminated <= k:
                        if (nr, nc, new_k_eliminated) not in visited:
                            if nr == m - 1 and nc == n - 1:
                                return steps + 1

                            visited.add((nr, nc, new_k_eliminated))
                            queue.append((nr, nc, new_k_eliminated, steps + 1))

        return -1