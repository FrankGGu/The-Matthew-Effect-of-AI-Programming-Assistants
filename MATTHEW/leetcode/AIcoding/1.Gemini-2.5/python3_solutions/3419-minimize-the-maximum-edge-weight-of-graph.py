class DSU:
    def __init__(self, n):
        self.parent = list(range(n))
        self.rank = [0] * n

    def find(self, i):
        if self.parent[i] == i:
            return i
        self.parent[i] = self.find(self.parent[i])
        return self.parent[i]

    def union(self, i, j):
        root_i = self.find(i)
        root_j = self.find(j)

        if root_i != root_j:
            if self.rank[root_i] < self.rank[root_j]:
                self.parent[root_i] = root_j
            elif self.rank[root_i] > self.rank[root_j]:
                self.parent[root_j] = root_i
            else:
                self.parent[root_j] = root_i
                self.rank[root_i] += 1
            return True
        return False

class Solution:
    def minMaxEdgeWeight(self, n: int, edges: list[list[int]]) -> int:
        edges.sort(key=lambda x: x[2])

        dsu = DSU(n)
        max_mst_weight = 0
        edges_in_mst = 0

        for u, v, w in edges:
            if dsu.union(u, v):
                max_mst_weight = max(max_mst_weight, w)
                edges_in_mst += 1
                if edges_in_mst == n - 1:
                    break

        return max_mst_weight