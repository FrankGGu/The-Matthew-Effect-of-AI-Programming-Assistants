import collections

class Solution:
    def nearestExit(self, maze: list[list[str]], entrance: list[int]) -> int:
        m, n = len(maze), len(maze[0])
        start_row, start_col = entrance[0], entrance[1]

        q = collections.deque([(start_row, start_col, 0)])
        visited = {(start_row, start_col)}

        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        while q:
            r, c, steps = q.popleft()

            for dr, dc in directions:
                nr, nc = r + dr, c + dc

                if 0 <= nr < m and 0 <= nc < n and maze[nr][nc] == '.' and (nr, nc) not in visited:
                    if (nr == 0 or nr == m - 1 or nc == 0 or nc == n - 1):
                        return steps + 1

                    visited.add((nr, nc))
                    q.append((nr, nc, steps + 1))

        return -1