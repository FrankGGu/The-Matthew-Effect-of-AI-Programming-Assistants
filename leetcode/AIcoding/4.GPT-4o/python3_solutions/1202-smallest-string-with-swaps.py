class UnionFind:
    def __init__(self, n):
        self.parent = list(range(n))

    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]

    def union(self, x, y):
        rootX = self.find(x)
        rootY = self.find(y)
        if rootX != rootY:
            self.parent[rootY] = rootX

class Solution:
    def smallestStringWithSwaps(self, s: str, pairs: List[List[int]]) -> str:
        n = len(s)
        uf = UnionFind(n)

        for x, y in pairs:
            uf.union(x, y)

        components = {}

        for i in range(n):
            root = uf.find(i)
            if root not in components:
                components[root] = []
            components[root].append(i)

        result = list(s)

        for indices in components.values():
            chars = sorted(result[i] for i in indices)
            indices.sort()
            for i, char in zip(indices, chars):
                result[i] = char

        return ''.join(result)