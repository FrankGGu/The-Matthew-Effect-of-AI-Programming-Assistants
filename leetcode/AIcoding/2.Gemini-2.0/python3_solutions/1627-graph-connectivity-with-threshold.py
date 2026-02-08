class DSU:
    def __init__(self, n):
        self.parent = list(range(n))

    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]

    def union(self, x, y):
        root_x = self.find(x)
        root_y = self.find(y)
        if root_x != root_y:
            self.parent[root_x] = root_y

class Solution:
    def areConnected(self, n: int, threshold: int, queries: list[list[int]]) -> list[bool]:
        dsu = DSU(n + 1)
        for i in range(threshold + 1, n + 1):
            for j in range(i * 2, n + 1, i):
                dsu.union(i, j)

        result = []
        for u, v in queries:
            result.append(dsu.find(u) == dsu.find(v))
        return result