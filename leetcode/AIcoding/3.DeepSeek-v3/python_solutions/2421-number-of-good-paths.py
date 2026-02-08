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
            return
        if self.rank[x_root] < self.rank[y_root]:
            self.parent[x_root] = y_root
        else:
            self.parent[y_root] = x_root
            if self.rank[x_root] == self.rank[y_root]:
                self.rank[x_root] += 1

class Solution:
    def numberOfGoodPaths(self, vals: List[int], edges: List[List[int]]) -> int:
        n = len(vals)
        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        value_to_nodes = defaultdict(list)
        for node in range(n):
            value_to_nodes[vals[node]].append(node)

        uf = UnionFind(n)
        res = 0

        for value in sorted(value_to_nodes.keys()):
            nodes = value_to_nodes[value]
            for node in nodes:
                for neighbor in adj[node]:
                    if vals[neighbor] <= vals[node]:
                        uf.union(node, neighbor)

            group_counts = defaultdict(int)
            for node in nodes:
                group_counts[uf.find(node)] += 1

            for count in group_counts.values():
                res += count * (count + 1) // 2

        return res