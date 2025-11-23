class Solution:
    def areConnected(self, n: int, threshold: int, queries: List[List[int]]) -> List[bool]:
        parent = list(range(n + 1))

        def find(x):
            while parent[x] != x:
                parent[x] = parent[parent[x]]
                x = parent[x]
            return x

        def union(x, y):
            px = find(x)
            py = find(y)
            if px != py:
                parent[py] = px

        for i in range(threshold + 1, n + 1):
            for j in range(i * 2, n + 1, i):
                union(i, j)

        result = []
        for u, v in queries:
            result.append(find(u) == find(v))

        return result