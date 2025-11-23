import collections

class Solution:
    def regionsBySlashes(self, grid: list[str]) -> int:
        n = len(grid)
        m = n * 3

        expanded_grid = [[0] * m for _ in range(m)]

        for r in range(n):
            for c in range(n):
                start_r = r * 3
                start_c = c * 3

                if grid[r][c] == '/':
                    expanded_grid[start_r][start_c + 2] = 1
                    expanded_grid[start_r + 1][start_c + 1] = 1
                    expanded_grid[start_r + 2][start_c] = 1
                elif grid[r][c] == '\\':
                    expanded_grid[start_r][start_c] = 1
                    expanded_grid[start_r + 1][start_c + 1] = 1
                    expanded_grid[start_r + 2][start_c + 2] = 1
                # If grid[r][c] == ' ', all cells in the 3x3 block remain 0

        regions = 0
        visited = [[False] * m for _ in range(m)]

        for r in range(m):
            for c in range(m):
                if expanded_grid[r][c] == 0 and not visited[r][c]:
                    regions += 1
                    q = collections.deque([(r, c)])
                    visited[r][c] = True

                    while q:
                        curr_r, curr_c = q.popleft()

                        for dr, dc in [(0, 1), (0, -1), (1, 0), (-1, 0)]:
                            next_r, next_c = curr_r + dr, curr_c + dc

                            if 0 <= next_r < m and 0 <= next_c < m and \
                               expanded_grid[next_r][next_c] == 0 and not visited[next_r][next_c]:
                                visited[next_r][next_c] = True
                                q.append((next_r, next_c))

        return regions