from collections import deque

class Solution:
    def minimumMoves(self, grid: list[list[int]], target: list[int]) -> int:
        n = len(grid)
        q = deque([(0, 0, 0, 0)])
        visited = set()
        visited.add((0, 0, 0))

        while q:
            r, c, state, moves = q.popleft()

            if r == target[0] and c == target[1] and state == 0:
                return moves

            # Move forward
            if state == 0:
                if c + 2 < n and grid[r][c + 2] == 0 and (r, c + 1, 0) not in visited:
                    q.append((r, c + 1, 0, moves + 1))
                    visited.add((r, c + 1, 0))
                if r + 1 < n and grid[r + 1][c] == 0 and grid[r + 1][c + 1] == 0 and (r + 1, c, 0) not in visited:
                    q.append((r + 1, c, 0, moves + 1))
                    visited.add((r + 1, c, 0))
                if r + 1 < n and c + 1 < n and grid[r + 1][c] == 0 and grid[r + 1][c + 1] == 0 and grid[r][c + 2] == 0 and (r, c, 1) not in visited:
                    q.append((r, c, 1, moves + 1))
                    visited.add((r, c, 1))
            elif state == 1:
                if r + 2 < n and grid[r + 2][c] == 0 and (r + 1, c, 1) not in visited:
                    q.append((r + 1, c, 1, moves + 1))
                    visited.add((r + 1, c, 1))
                if c + 1 < n and grid[r][c + 1] == 0 and grid[r + 1][c + 1] == 0 and (r, c + 1, 1) not in visited:
                    q.append((r, c + 1, 1, moves + 1))
                    visited.add((r, c + 1, 1))
                if r + 1 < n and c + 1 < n and grid[r + 2][c] == 0 and grid[r][c + 1] == 0 and grid[r + 1][c + 1] == 0 and (r, c, 0) not in visited:
                    q.append((r, c, 0, moves + 1))
                    visited.add((r, c, 0))

        return -1