from itertools import product
from collections import deque

class Solution:
    def minFlips(self, mat: List[List[int]]) -> int:
        m, n = len(mat), len(mat[0])
        target = 0
        start = 0
        for i in range(m):
            for j in range(n):
                start |= mat[i][j] << (i * n + j)

        directions = [(0, 0), (0, 1), (0, -1), (1, 0), (-1, 0)]
        visited = set()
        queue = deque()
        queue.append((start, 0))
        visited.add(start)

        while queue:
            current, steps = queue.popleft()
            if current == target:
                return steps
            for i in range(m):
                for j in range(n):
                    next_state = current
                    for di, dj in directions:
                        ni, nj = i + di, j + dj
                        if 0 <= ni < m and 0 <= nj < n:
                            next_state ^= 1 << (ni * n + nj)
                    if next_state not in visited:
                        visited.add(next_state)
                        queue.append((next_state, steps + 1))
        return -1