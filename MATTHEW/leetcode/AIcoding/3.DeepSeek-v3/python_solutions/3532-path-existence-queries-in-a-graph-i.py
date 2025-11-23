class UnionFind:
    def __init__(self, size):
        self.parent = list(range(size + 1))

    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]

    def union(self, x, y):
        fx = self.find(x)
        fy = self.find(y)
        if fx != fy:
            self.parent[fy] = fx

class Solution:
    def distanceLimitedPathsExist(self, n: int, edgeList: List[List[int]], queries: List[List[int]]) -> List[bool]:
        edgeList.sort(key=lambda x: x[2])
        queries = sorted([(u, v, limit, i) for i, (u, v, limit) in enumerate(queries)], key=lambda x: x[2])
        uf = UnionFind(n)
        res = [False] * len(queries)
        edge_idx = 0
        for u, v, limit, idx in queries:
            while edge_idx < len(edgeList) and edgeList[edge_idx][2] < limit:
                uf.union(edgeList[edge_idx][0], edgeList[edge_idx][1])
                edge_idx += 1
            res[idx] = (uf.find(u) == uf.find(v))
        return res