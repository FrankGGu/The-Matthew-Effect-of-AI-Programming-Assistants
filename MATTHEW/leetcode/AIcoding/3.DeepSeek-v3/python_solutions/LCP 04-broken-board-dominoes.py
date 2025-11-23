class Solution:
    def domino(self, n: int, m: int, broken: List[List[int]]) -> int:
        broken_set = set((i, j) for i, j in broken)
        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]

        def dfs(i, j, visited):
            for di, dj in directions:
                ni, nj = i + di, j + dj
                if 0 <= ni < n and 0 <= nj < m and (ni, nj) not in broken_set and (ni, nj) not in visited:
                    visited.add((ni, nj))
                    if match[ni][nj] == (-1, -1) or dfs(*match[ni][nj], visited):
                        match[i][j] = (ni, nj)
                        match[ni][nj] = (i, j)
                        return True
            return False

        match = [[(-1, -1) for _ in range(m)] for _ in range(n)]
        res = 0
        for i in range(n):
            for j in range(m):
                if (i + j) % 2 == 0 and (i, j) not in broken_set and match[i][j] == (-1, -1):
                    visited = set()
                    if dfs(i, j, visited):
                        res += 1
        return res