class UnionFind:
    def __init__(self, n):
        self.parent = list(range(n))
        self.size = [1] * n

    def find(self, i):
        if self.parent[i] == i:
            return i
        self.parent[i] = self.find(self.parent[i])
        return self.parent[i]

    def union(self, i, j):
        root_i = self.find(i)
        root_j = self.find(j)
        if root_i != root_j:
            if self.size[root_i] < self.size[root_j]:
                root_i, root_j = root_j, root_i
            self.parent[root_j] = root_i
            self.size[root_i] += self.size[root_j]

class Solution:
    def numberOfGoodPaths(self, vals, edges):
        n = len(vals)
        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        nodes = sorted(range(n), key=lambda x: vals[x])
        uf = UnionFind(n)
        count = {}
        res = 0
        for i in nodes:
            count[i] = 1
            for neighbor in adj[i]:
                if vals[neighbor] <= vals[i]:
                    uf.union(i, neighbor)
            root = uf.find(i)
            if root not in count:
                count[root] = 0
            res += count[root] * count.get(uf.find(i),1)

            temp_count = {}
            for neighbor in adj[i]:
                if vals[neighbor] == vals[i]:
                    root_neighbor = uf.find(neighbor)
                    if root_neighbor not in temp_count:
                        temp_count[root_neighbor] = 0
                    temp_count[root_neighbor] +=1

            count[uf.find(i)] = 1
            for root_neighbor in temp_count:
                count[uf.find(i)] += temp_count[root_neighbor]

        return res