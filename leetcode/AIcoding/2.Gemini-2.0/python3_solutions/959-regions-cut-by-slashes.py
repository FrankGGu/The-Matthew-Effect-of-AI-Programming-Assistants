class Solution:
    def regionsBySlashes(self, grid: List[str]) -> int:
        n = len(grid)
        uf = DSU(3 * n * n)
        for i in range(n):
            for j in range(n):
                idx = i * n + j
                if grid[i][j] != '\\':
                    uf.union(idx * 3 + 0, idx * 3 + 1)
                if grid[i][j] != '/':
                    uf.union(idx * 3 + 1, idx * 3 + 2)
                if grid[i][j] != '\\':
                    uf.union(idx * 3 + 2, idx * 3 + 0)
                if i > 0:
                    uf.union(idx * 3 + 0, (idx - n) * 3 + 2)
                if i < n - 1:
                    uf.union(idx * 3 + 2, (idx + n) * 3 + 0)
                if j > 0:
                    uf.union(idx * 3 + 1, (idx - 1) * 3 + 1)
                if j < n - 1:
                    uf.union(idx * 3 + 1, (idx + 1) * 3 + 1)
        return uf.count

class DSU:
    def __init__(self, N):
        self.parent = list(range(N))
        self.count = N

    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]

    def union(self, x, y):
        rootX = self.find(x)
        rootY = self.find(y)
        if rootX != rootY:
            self.parent[rootX] = rootY
            self.count -= 1