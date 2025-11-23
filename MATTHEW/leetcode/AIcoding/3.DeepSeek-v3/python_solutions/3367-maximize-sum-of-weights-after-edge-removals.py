class UnionFind:
    def __init__(self, size):
        self.parent = list(range(size))
        self.rank = [1] * size

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
            x_root, y_root = y_root, x_root
        self.parent[y_root] = x_root
        self.rank[x_root] += self.rank[y_root]
        return True

class Solution:
    def maxSumAfterRemoval(self, edges: List[List[int]], weight: List[int]) -> int:
        n = len(weight)
        uf = UnionFind(n)
        edges.sort(key=lambda x: min(weight[x[0]], weight[x[1]]), reverse=True)

        total = sum(weight)
        res = 0

        for u, v in edges:
            w = min(weight[u], weight[v])
            if uf.find(u) != uf.find(v):
                res += w
            uf.union(u, v)

        return total - res