class UnionFind:
    def __init__(self, n):
        self.parent = list(range(n))
        self.rank = [0] * n

    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]

    def union(self, x, y):
        x_root = self.find(x)
        y_root = self.find(y)
        if x_root == y_root:
            return False
        if self.rank[x_root] < self.rank[y_root]:
            self.parent[x_root] = y_root
        else:
            self.parent[y_root] = x_root
            if self.rank[x_root] == self.rank[y_root]:
                self.rank[x_root] += 1
        return True

class Solution:
    def findCriticalAndPseudoCriticalEdges(self, n: int, edges: List[List[int]]) -> List[List[int]]:
        m = len(edges)
        for i in range(m):
            edges[i].append(i)
        edges.sort(key=lambda x: x[2])

        def kruskal(blocked_edge=None, must_edge=None):
            uf = UnionFind(n)
            total = 0
            count = 0
            if must_edge is not None:
                u, v, w, idx = edges[must_edge]
                uf.union(u, v)
                total += w
                count += 1
            for i in range(m):
                if i == blocked_edge:
                    continue
                u, v, w, idx = edges[i]
                if uf.union(u, v):
                    total += w
                    count += 1
                    if count == n - 1:
                        break
            return total if count == n - 1 else float('inf')

        mst_weight = kruskal()
        critical = []
        pseudo_critical = []

        for i in range(m):
            if kruskal(blocked_edge=i) > mst_weight:
                critical.append(edges[i][3])
            elif kruskal(must_edge=i) == mst_weight:
                pseudo_critical.append(edges[i][3])

        return [critical, pseudo_critical]