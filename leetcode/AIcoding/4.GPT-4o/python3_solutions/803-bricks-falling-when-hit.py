class Solution:
    def hitBricks(self, grid: List[List[int]], hits: List[List[int]]) -> List[int]:
        m, n = len(grid), len(grid[0])

        def find(x):
            if parent[x] != x:
                parent[x] = find(parent[x])
            return parent[x]

        def union(x, y):
            rootX = find(x)
            rootY = find(y)
            if rootX != rootY:
                if size[rootX] < size[rootY]:
                    rootX, rootY = rootY, rootX
                parent[rootY] = rootX
                size[rootX] += size[rootY]

        def index(i, j):
            return i * n + j

        parent = [0] * (m * n + 1)
        size = [0] * (m * n + 1)

        for i in range(m * n + 1):
            parent[i] = i
            size[i] = 1

        for i in range(m):
            for j in range(n):
                if grid[i][j] == 1:
                    if i == 0:
                        union(index(i, j), m * n)
                    if i > 0 and grid[i - 1][j] == 1:
                        union(index(i, j), index(i - 1, j))
                    if j > 0 and grid[i][j - 1] == 1:
                        union(index(i, j), index(i, j - 1))

        result = []

        for i, j in reversed(hits):
            if grid[i][j] == 0:
                result.append(0)
                continue

            grid[i][j] = 1
            if i == 0:
                union(index(i, j), m * n)

            for x, y in [(i - 1, j), (i + 1, j), (i, j - 1), (i, j + 1)]:
                if 0 <= x < m and 0 <= y < n and grid[x][y] == 1:
                    union(index(i, j), index(x, y))

            result.append(max(0, size[find(m * n)] - 1))

        return result[::-1]