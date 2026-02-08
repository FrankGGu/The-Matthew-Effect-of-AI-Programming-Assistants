class DSU:
    def __init__(self, n):
        self.parent = list(range(n))
        self.rank = [0] * n

    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]

    def union(self, x, y):
        rootX = self.find(x)
        rootY = self.find(y)
        if rootX != rootY:
            if self.rank[rootX] < self.rank[rootY]:
                self.parent[rootX] = rootY
            elif self.rank[rootX] > self.rank[rootY]:
                self.parent[rootY] = rootX
            else:
                self.parent[rootY] = rootX
                self.rank[rootX] += 1
            return True
        return False

class Solution:
    def distanceLimitedPathsExist(self, n: int, edgeList: List[List[int]], queries: List[List[int]]) -> List[bool]:
        edgeList.sort(key=lambda x: x[2])
        queries_with_index = []
        for i, query in enumerate(queries):
            queries_with_index.append((query[0], query[1], query[2], i))
        queries_with_index.sort(key=lambda x: x[2])

        dsu = DSU(n)
        results = [False] * len(queries)
        edge_index = 0

        for u, v, limit, index in queries_with_index:
            while edge_index < len(edgeList) and edgeList[edge_index][2] < limit:
                dsu.union(edgeList[edge_index][0], edgeList[edge_index][1])
                edge_index += 1

            if dsu.find(u) == dsu.find(v):
                results[index] = True

        return results