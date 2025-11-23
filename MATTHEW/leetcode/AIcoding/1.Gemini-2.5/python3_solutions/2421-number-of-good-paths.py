from collections import defaultdict, Counter

class DSU:
    def __init__(self, n, vals):
        self.parent = list(range(n))
        self.size = [1] * n  # For union by size
        self.val_counts = [Counter({vals[i]: 1}) for i in range(n)]

    def find(self, i):
        if self.parent[i] == i:
            return i
        self.parent[i] = self.find(self.parent[i])
        return self.parent[i]

    def union(self, i, j, current_val):
        root_i = self.find(i)
        root_j = self.find(j)

        if root_i != root_j:
            count_i = self.val_counts[root_i][current_val]
            count_j = self.val_counts[root_j][current_val]

            new_paths = count_i * count_j

            if self.size[root_i] < self.size[root_j]:
                root_i, root_j = root_j, root_i

            self.parent[root_j] = root_i
            self.size[root_i] += self.size[root_j]

            self.val_counts[root_i].update(self.val_counts[root_j])

            return new_paths
        return 0

class Solution:
    def numberOfGoodPaths(self, vals: list[int], edges: list[list[int]]) -> int:
        n = len(vals)
        adj = defaultdict(list)
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        nodes_by_val = defaultdict(list)
        for i in range(n):
            nodes_by_val[vals[i]].append(i)

        dsu = DSU(n, vals)

        ans = n 

        sorted_unique_vals = sorted(nodes_by_val.keys())

        for current_val in sorted_unique_vals:
            for node in nodes_by_val[current_val]:
                for neighbor in adj[node]:
                    if vals[neighbor] <= current_val:
                        ans += dsu.union(node, neighbor, current_val)

        return ans