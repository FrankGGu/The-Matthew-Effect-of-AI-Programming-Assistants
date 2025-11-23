class UnionFind:
    def __init__(self, size):
        self.parent = list(range(size))
        self.rank = [0] * size

    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]

    def union(self, x, y):
        x_root = self.find(x)
        y_root = self.find(y)
        if x_root == y_root:
            return
        if self.rank[x_root] < self.rank[y_root]:
            self.parent[x_root] = y_root
        else:
            self.parent[y_root] = x_root
            if self.rank[x_root] == self.rank[y_root]:
                self.rank[x_root] += 1

class Solution:
    def minimumCost(self, n: int, edges: List[List[int]], query: List[List[int]]) -> List[int]:
        uf = UnionFind(n)
        for u, v, w in edges:
            uf.union(u, v)

        component_or = [0] * n
        for u, v, w in edges:
            root = uf.find(u)
            component_or[root] |= w

        res = []
        for s, t in query:
            if s == t:
                res.append(0)
                continue
            if uf.find(s) != uf.find(t):
                res.append(-1)
            else:
                res.append(component_or[uf.find(s)])
        return res