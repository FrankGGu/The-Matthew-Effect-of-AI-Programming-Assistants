from collections import deque

class Solution:
    def minFlips(self, mat: list[list[int]]) -> int:
        m, n = len(mat), len(mat[0])
        start = 0
        for i in range(m):
            for j in range(n):
                start |= (mat[i][j] << (i * n + j))

        q = deque([(start, 0)])
        visited = {start}

        while q:
            curr, steps = q.popleft()
            if curr == 0:
                return steps

            for i in range(m):
                for j in range(n):
                    next_state = curr ^ (1 << (i * n + j))
                    if i > 0:
                        next_state ^= (1 << ((i - 1) * n + j))
                    if i < m - 1:
                        next_state ^= (1 << ((i + 1) * n + j))
                    if j > 0:
                        next_state ^= (1 << (i * n + (j - 1)))
                    if j < n - 1:
                        next_state ^= (1 << (i * n + (j + 1)))

                    if next_state not in visited:
                        visited.add(next_state)
                        q.append((next_state, steps + 1))

        return -1