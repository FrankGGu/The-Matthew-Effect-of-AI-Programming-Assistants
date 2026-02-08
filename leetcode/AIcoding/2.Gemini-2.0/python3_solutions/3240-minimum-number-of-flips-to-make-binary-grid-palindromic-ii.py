from collections import deque

class Solution:
    def minFlips(self, grid: list[list[int]]) -> int:
        m, n = len(grid), len(grid[0])
        start = 0
        for i in range(m):
            for j in range(n):
                start = (start << 1) | grid[i][j]

        target = 0
        for i in range(m):
            for j in range(n):
                target = (target << 1) | grid[m - 1 - i][n - 1 - j]

        if start == target:
            return 0

        q = deque([(start, 0)])
        visited = {start}

        while q:
            curr, steps = q.popleft()

            for i in range(m):
                for j in range(n):
                    nxt = curr ^ (1 << (i * n + j))
                    if nxt == target:
                        return steps + 1
                    if nxt not in visited:
                        visited.add(nxt)
                        q.append((nxt, steps + 1))

        return -1