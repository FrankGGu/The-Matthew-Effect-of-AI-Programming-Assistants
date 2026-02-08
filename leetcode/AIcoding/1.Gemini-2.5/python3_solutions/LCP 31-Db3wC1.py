from collections import deque

class Solution:
    def solve(self, grid: list[list[int]], start: tuple[int, int], end: tuple[int, int]) -> int:
        rows = len(grid)
        cols = len(grid[0])

        def is_blocked_at_time(r: int, c: int, time: int) -> bool:
            return grid[r][c] == 1

        q = deque([(start[0], start[1], 0)])

        visited = set([(start[0], start[1], 0)])

        directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

        while q:
            r, c, current_time = q.popleft()

            if (r, c) == end:
                return current_time

            for dr, dc in directions:
                nr, nc = r + dr, c + dc
                next_time = current_time + 1

                if 0 <= nr < rows and 0 <= nc < cols:
                    if not is_blocked_at_time(nr, nc, next_time):
                        if (nr, nc, next_time) not in visited:
                            visited.add((nr, nc, next_time))
                            q.append((nr, nc, next_time))

        return -1