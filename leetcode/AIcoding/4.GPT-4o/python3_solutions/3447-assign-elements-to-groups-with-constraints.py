class Solution:
    def canAssign(self, n: int, restrictions: List[List[int]]) -> bool:
        parent = list(range(n))

        def find(x):
            if parent[x] != x:
                parent[x] = find(parent[x])
            return parent[x]

        def union(x, y):
            rootX = find(x)
            rootY = find(y)
            if rootX != rootY:
                parent[rootY] = rootX

        for u, v in restrictions:
            union(u, v)

        group = {}
        for i in range(n):
            root = find(i)
            if root not in group:
                group[root] = set()
            group[root].add(i)

        return all(len(g) <= 2 for g in group.values())