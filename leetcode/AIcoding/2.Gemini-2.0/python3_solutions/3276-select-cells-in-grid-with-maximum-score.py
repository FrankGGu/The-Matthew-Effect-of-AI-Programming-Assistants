class Solution:
    def maxPoints(self, grid: List[List[int]], queries: List[int]) -> List[int]:
        m, n = len(grid), len(grid[0])
        points = []
        for i in range(m):
            for j in range(n):
                points.append((grid[i][j], i, j))
        points.sort()
        q = sorted([(queries[i], i) for i in range(len(queries))])
        ans = [0] * len(queries)
        uf = {}

        def find(x):
            if x not in uf:
                uf[x] = x
            if uf[x] != x:
                uf[x] = find(uf[x])
            return uf[x]

        def union(x, y):
            rootX = find(x)
            rootY = find(y)
            if rootX != rootY:
                uf[rootX] = rootY

        idx = 0
        visited = set()
        for query, i in q:
            while idx < len(points) and points[idx][0] < query:
                val, r, c = points[idx]
                visited.add((r, c))
                if r > 0 and (r - 1, c) in visited:
                    union((r, c), (r - 1, c))
                if r < m - 1 and (r + 1, c) in visited:
                    union((r, c), (r + 1, c))
                if c > 0 and (r, c - 1) in visited:
                    union((r, c), (r, c - 1))
                if c < n - 1 and (r, c + 1) in visited:
                    union((r, c), (r, c + 1))
                idx += 1

            if (0, 0) in visited:
                root = find((0, 0))
                count = 0
                for r in range(m):
                    for c in range(n):
                        if (r, c) in visited and find((r, c)) == root:
                            count += 1
                ans[i] = count
            else:
                ans[i] = 0
        return ans