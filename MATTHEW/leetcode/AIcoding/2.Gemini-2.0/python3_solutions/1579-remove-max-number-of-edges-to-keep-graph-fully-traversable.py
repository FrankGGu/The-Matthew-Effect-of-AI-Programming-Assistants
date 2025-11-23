class UnionFind:
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
    def maxNumEdgesToRemove(self, n: int, edges: List[List[int]]) -> int:
        alice = UnionFind(n)
        bob = UnionFind(n)
        removed_edges = 0

        for type, u, v in edges:
            if type == 3:
                if alice.union(u - 1, v - 1):
                    bob.union(u - 1, v - 1)
                else:
                    removed_edges += 1

        for type, u, v in edges:
            if type == 1:
                if not alice.union(u - 1, v - 1):
                    removed_edges += 1
            elif type == 2:
                if not bob.union(u - 1, v - 1):
                    removed_edges += 1

        if len(set(alice.find(i) for i in range(n))) != 1 or len(set(bob.find(i) for i in range(n))) != 1:
            return -1

        return removed_edges