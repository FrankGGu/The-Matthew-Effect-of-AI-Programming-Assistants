class DSU:
    def __init__(self, n):
        self.parent = list(range(n + 1))
        self.size = [1] * (n + 1)

    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]

    def union(self, x, y):
        rootX = self.find(x)
        rootY = self.find(y)
        if rootX != rootY:
            if self.size[rootX] < self.size[rootY]:
                rootX, rootY = rootY, rootX
            self.parent[rootY] = rootX
            self.size[rootX] += self.size[rootY]
            return True
        return False

class Solution:
    def countConnectedComponents(self, n: int, edges: list[list[int]]) -> int:
        dsu = DSU(n)
        for u, v in edges:
            dsu.union(u, v)

        components = set()
        for i in range(1, n + 1):
            components.add(dsu.find(i))

        return len(components)