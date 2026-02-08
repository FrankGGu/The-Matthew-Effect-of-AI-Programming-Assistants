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
            return False
        if self.rank[x_root] < self.rank[y_root]:
            self.parent[x_root] = y_root
        else:
            self.parent[y_root] = x_root
            if self.rank[x_root] == self.rank[y_root]:
                self.rank[x_root] += 1
        return True

class Solution:
    def maxSum(self, n: int, edges: List[List[int]], maxTime: List[int]) -> int:
        edges_sorted = sorted([(maxTime[i], edges[i][0], edges[i][1], i) for i in range(len(edges))], reverse=True)
        uf = UnionFind(n)
        total_sum = 0
        selected_edges = []

        for edge in edges_sorted:
            time, u, v, idx = edge
            if uf.union(u, v):
                total_sum += time
                selected_edges.append(idx)

        return total_sum