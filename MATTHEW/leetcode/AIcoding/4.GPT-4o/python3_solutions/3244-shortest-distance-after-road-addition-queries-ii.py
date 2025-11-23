class UnionFind:
    def __init__(self, n):
        self.parent = list(range(n))
        self.rank = [1] * n

    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]

    def union(self, x, y):
        rootX = self.find(x)
        rootY = self.find(y)
        if rootX != rootY:
            if self.rank[rootX] > self.rank[rootY]:
                self.parent[rootY] = rootX
            elif self.rank[rootX] < self.rank[rootY]:
                self.parent[rootX] = rootY
            else:
                self.parent[rootY] = rootX
                self.rank[rootX] += 1

class Solution:
    def shortestDistance(self, n: int, roads: List[List[int]], queries: List[List[int]]) -> List[int]:
        uf = UnionFind(n)
        graph = defaultdict(list)
        for u, v, w in roads:
            graph[u].append((v, w))
            graph[v].append((u, w))
            uf.union(u, v)

        distances = {}
        for u in range(n):
            for v, w in graph[u]:
                rootU = uf.find(u)
                rootV = uf.find(v)
                if rootU == rootV:
                    if (u, v) not in distances:
                        distances[(u, v)] = w
                        distances[(v, u)] = w
                    else:
                        distances[(u, v)] = min(distances[(u, v)], w)
                        distances[(v, u)] = min(distances[(v, u)], w)

        result = []
        for u, v in queries:
            if uf.find(u) == uf.find(v):
                result.append(0)
            else:
                result.append(-1)
        return result