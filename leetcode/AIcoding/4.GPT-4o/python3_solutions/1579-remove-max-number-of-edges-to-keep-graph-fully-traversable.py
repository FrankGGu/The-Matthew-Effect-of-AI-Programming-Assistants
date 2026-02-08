class UnionFind:
    def __init__(self, n):
        self.parent = list(range(n))
        self.rank = [1] * n
        self.count = n

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
            self.count -= 1
            return True
        return False

def maxNumEdgesToRemove(n: int, edges: List[List[int]]) -> int:
    ufA = UnionFind(n)
    ufB = UnionFind(n)

    total_edges = 0
    removed_edges = 0

    for t, u, v in edges:
        if t == 3:
            if ufA.union(u - 1, v - 1):
                ufB.union(u - 1, v - 1)
                total_edges += 1
            else:
                removed_edges += 1

    for t, u, v in edges:
        if t == 1:
            if ufA.union(u - 1, v - 1):
                total_edges += 1
            else:
                removed_edges += 1
        elif t == 2:
            if ufB.union(u - 1, v - 1):
                total_edges += 1
            else:
                removed_edges += 1

    if ufA.count != 1 or ufB.count != 1:
        return -1

    return removed_edges