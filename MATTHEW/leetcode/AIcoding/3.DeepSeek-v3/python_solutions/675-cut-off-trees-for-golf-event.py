import heapq

class Solution:
    def cutOffTree(self, forest: List[List[int]]) -> int:
        if not forest or not forest[0]:
            return -1

        m, n = len(forest), len(forest[0])
        trees = []
        for i in range(m):
            for j in range(n):
                if forest[i][j] > 1:
                    trees.append((forest[i][j], i, j))
        trees.sort()

        def bfs(start_i, start_j, target_i, target_j):
            queue = collections.deque([(start_i, start_j, 0)])
            visited = set()
            visited.add((start_i, start_j))
            while queue:
                i, j, steps = queue.popleft()
                if i == target_i and j == target_j:
                    return steps
                for di, dj in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                    ni, nj = i + di, j + dj
                    if 0 <= ni < m and 0 <= nj < n and forest[ni][nj] != 0 and (ni, nj) not in visited:
                        visited.add((ni, nj))
                        queue.append((ni, nj, steps + 1))
            return -1

        total_steps = 0
        start_i, start_j = 0, 0
        for height, target_i, target_j in trees:
            steps = bfs(start_i, start_j, target_i, target_j)
            if steps == -1:
                return -1
            total_steps += steps
            start_i, start_j = target_i, target_j

        return total_steps