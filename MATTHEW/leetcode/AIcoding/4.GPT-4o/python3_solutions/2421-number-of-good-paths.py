class UnionFind:
    def __init__(self, n):
        self.parent = list(range(n))
        self.rank = [1] * n
        self.count = [1] * n

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
                self.count[rootX] += self.count[rootY]
            elif self.rank[rootX] < self.rank[rootY]:
                self.parent[rootX] = rootY
                self.count[rootY] += self.count[rootX]
            else:
                self.parent[rootY] = rootX
                self.count[rootX] += self.count[rootY]
                self.rank[rootX] += 1

class Solution:
    def numberOfGoodPaths(self, vals: List[int], edges: List[List[int]]) -> int:
        n = len(vals)
        uf = UnionFind(n)
        graph = defaultdict(list)

        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        value_to_nodes = defaultdict(list)
        for i, val in enumerate(vals):
            value_to_nodes[val].append(i)

        result = 0

        for value in sorted(value_to_nodes.keys()):
            nodes = value_to_nodes[value]
            for node in nodes:
                for neighbor in graph[node]:
                    if vals[neighbor] <= value:
                        uf.union(node, neighbor)

            count = defaultdict(int)
            for node in nodes:
                root = uf.find(node)
                count[root] += 1

            for cnt in count.values():
                result += cnt * (cnt + 1) // 2

        return result