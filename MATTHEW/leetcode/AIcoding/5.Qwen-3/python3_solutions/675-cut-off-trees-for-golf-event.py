from collections import deque
from typing import List

class Solution:
    def cutOffTree(self, forest: List[List[int]]) -> int:
        if not forest or not forest[0]:
            return 0

        m, n = len(forest), len(forest[0])
        trees = []

        for i in range(m):
            for j in range(n):
                if forest[i][j] > 0:
                    trees.append((forest[i][j], i, j))

        trees.sort()
        total_steps = 0
        start_i, start_j = 0, 0

        for height, i, j in trees:
            steps = self.bfs(forest, start_i, start_j, i, j, m, n)
            if steps == -1:
                return -1
            total_steps += steps
            start_i, start_j = i, j

        return total_steps

    def bfs(self, forest: List[List[int]], start_i: int, start_j: int, target_i: int, target_j: int, m: int, n: int) -> int:
        if start_i == target_i and start_j == target_j:
            return 0

        visited = [[False] * n for _ in range(m)]
        queue = deque()
        queue.append((start_i, start_j, 0))
        visited[start_i][start_j] = True

        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]

        while queue:
            i, j, steps = queue.popleft()
            for dx, dy in directions:
                ni, nj = i + dx, j + dy
                if 0 <= ni < m and 0 <= nj < n and not visited[ni][nj] and forest[ni][nj] > 0:
                    if ni == target_i and nj == target_j:
                        return steps + 1
                    visited[ni][nj] = True
                    queue.append((ni, nj, steps + 1))

        return -1