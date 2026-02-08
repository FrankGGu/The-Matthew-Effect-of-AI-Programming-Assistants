class DSU:
    def __init__(self, n):
        self.parent = list(range(n))
        self.rank = [0] * n

    def find(self, i):
        if self.parent[i] == i:
            return i
        self.parent[i] = self.find(self.parent[i])
        return self.parent[i]

    def union(self, i, j):
        root_i = self.find(i)
        root_j = self.find(j)

        if root_i != root_j:
            if self.rank[root_i] < self.rank[root_j]:
                self.parent[root_i] = root_j
            elif self.rank[root_i] > self.rank[root_j]:
                self.parent[root_j] = root_i
            else:
                self.parent[root_j] = root_i
                self.rank[root_i] += 1
            return True
        return False

class Solution:
    def distanceLimitedPathsExist(self, n: int, edgeList: list[list[int]], queries: list[list[int]]) -> list[bool]:
        dsu = DSU(n)

        edgeList.sort(key=lambda x: x[2])

        indexed_queries = []
        for i, query in enumerate(queries):
            indexed_queries.append((query[0], query[1], query[2], i))
        indexed_queries.sort(key=lambda x: x[2])

        ans = [False] * len(queries)
        edge_idx = 0

        for p, q, limit, original_idx in indexed_queries:
            while edge_idx < len(edgeList) and edgeList[edge_idx][2] < limit:
                u, v, w = edgeList[edge_idx]
                dsu.union(u, v)
                edge_idx += 1

            if dsu.find(p) == dsu.find(q):
                ans[original_idx] = True

        return ans