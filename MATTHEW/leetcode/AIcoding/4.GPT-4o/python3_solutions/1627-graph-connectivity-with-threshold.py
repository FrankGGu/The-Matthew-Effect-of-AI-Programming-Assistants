class UnionFind:
    def __init__(self, n):
        self.parent = list(range(n + 1))
        self.rank = [1] * (n + 1)

    def find(self, u):
        if self.parent[u] != u:
            self.parent[u] = self.find(self.parent[u])
        return self.parent[u]

    def union(self, u, v):
        rootU = self.find(u)
        rootV = self.find(v)
        if rootU != rootV:
            if self.rank[rootU] > self.rank[rootV]:
                self.parent[rootV] = rootU
            elif self.rank[rootU] < self.rank[rootV]:
                self.parent[rootU] = rootV
            else:
                self.parent[rootV] = rootU
                self.rank[rootU] += 1

class Solution:
    def areConnected(self, n: int, edgeList: List[List[int]], threshold: int) -> bool:
        uf = UnionFind(n)
        for u, v, w in edgeList:
            if w > threshold:
                uf.union(u, v)
        root = uf.find(1)
        for i in range(2, n + 1):
            if uf.find(i) != root:
                return False
        return True