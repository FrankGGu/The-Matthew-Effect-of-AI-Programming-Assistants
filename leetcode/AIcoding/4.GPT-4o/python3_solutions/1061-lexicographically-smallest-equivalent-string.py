class UnionFind:
    def __init__(self):
        self.parent = {}

    def find(self, x):
        if x != self.parent.setdefault(x, x):
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]

    def union(self, x, y):
        rootX = self.find(x)
        rootY = self.find(y)
        if rootX != rootY:
            self.parent[rootY] = rootX

class Solution:
    def smallestEquivalentString(self, A: str, B: str, baseStr: str) -> str:
        uf = UnionFind()
        for a, b in zip(A, B):
            uf.union(a, b)

        groups = {}
        for char in uf.parent:
            root = uf.find(char)
            if root not in groups:
                groups[root] = []
            groups[root].append(char)

        for group in groups.values():
            group.sort()

        result = []
        for char in baseStr:
            root = uf.find(char)
            result.append(groups[root][0])

        return ''.join(result)