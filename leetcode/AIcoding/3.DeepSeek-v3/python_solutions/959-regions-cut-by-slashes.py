class Solution:
    def regionsBySlashes(self, grid: List[str]) -> int:
        n = len(grid)
        parent = [i for i in range(4 * n * n)]

        def find(u):
            while parent[u] != u:
                parent[u] = parent[parent[u]]
                u = parent[u]
            return u

        def union(u, v):
            root_u = find(u)
            root_v = find(v)
            if root_u != root_v:
                parent[root_v] = root_u

        for i in range(n):
            for j in range(n):
                base = 4 * (i * n + j)
                c = grid[i][j]
                if c == '/':
                    union(base, base + 3)
                    union(base + 1, base + 2)
                elif c == '\\':
                    union(base, base + 1)
                    union(base + 2, base + 3)
                else:
                    union(base, base + 1)
                    union(base + 1, base + 2)
                    union(base + 2, base + 3)

                if i > 0:
                    union(base, base - 4 * n + 2)
                if j > 0:
                    union(base + 3, base - 4 + 1)

        res = 0
        for i in range(4 * n * n):
            if parent[i] == i:
                res += 1
        return res