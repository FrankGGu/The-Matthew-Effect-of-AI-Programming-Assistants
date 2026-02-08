class UnionFind:
    def __init__(self, size):
        self.parent = list(range(size + 1))
        self.rank = [0] * (size + 1)
        self.components = size

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
        self.components -= 1
        return True

class Solution:
    def maxNumEdgesToRemove(self, n: int, edges: List[List[int]]) -> int:
        alice = UnionFind(n)
        bob = UnionFind(n)
        edges.sort(reverse=True)
        res = 0

        for t, u, v in edges:
            if t == 3:
                a = alice.union(u, v)
                b = bob.union(u, v)
                if not a and not b:
                    res += 1
            elif t == 2:
                if not bob.union(u, v):
                    res += 1
            else:
                if not alice.union(u, v):
                    res += 1

        if alice.components != 1 or bob.components != 1:
            return -1
        return res