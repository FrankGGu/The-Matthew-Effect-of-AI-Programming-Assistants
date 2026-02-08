class Solution:
    def countWays(self, n: int, edges: List[List[int]]) -> int:
        mod = 10**9 + 7
        parent = list(range(n + 1))
        size = [1] * (n + 1)

        def find(x):
            if parent[x] != x:
                parent[x] = find(parent[x])
            return parent[x]

        def union(x, y):
            rootX = find(x)
            rootY = find(y)
            if rootX != rootY:
                if size[rootX] < size[rootY]:
                    rootX, rootY = rootY, rootX
                parent[rootY] = rootX
                size[rootX] += size[rootY]

        for u, v in edges:
            union(u, v)

        distinct_roots = len(set(find(i) for i in range(1, n + 1)))
        return pow(2, distinct_roots - 1, mod)