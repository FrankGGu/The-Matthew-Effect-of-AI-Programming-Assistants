class UnionFind:
    def __init__(self, n):
        self.parent = list(range(n))
        self.rank = [1] * n

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
            return True
        return False

class Solution:
    def findCriticalAndPseudoCriticalEdges(self, n: int, edges: List[List[int]]) -> List[List[int]]:
        edges = [[u, v, w, i] for i, (u, v, w) in enumerate(edges)]
        edges.sort(key=lambda x: x[2])

        def kruskal(n, edges, skip_edge=None, include_edge=None):
            uf = UnionFind(n)
            total_cost = 0
            if include_edge is not None:
                u, v, w, _ = edges[include_edge]
                uf.union(u, v)
                total_cost += w

            for i, (u, v, w, idx) in enumerate(edges):
                if i == skip_edge:
                    continue
                if uf.union(u, v):
                    total_cost += w

            return total_cost if uf.rank[uf.find(0)] == n else float('inf')

        mst_cost = kruskal(n, edges)
        critical, pseudo_critical = [], []

        for i in range(len(edges)):
            if kruskal(n, edges, skip_edge=i) > mst_cost:
                critical.append(edges[i][3])
            elif kruskal(n, edges, include_edge=i) == mst_cost:
                pseudo_critical.append(edges[i][3])

        return [critical, pseudo_critical]