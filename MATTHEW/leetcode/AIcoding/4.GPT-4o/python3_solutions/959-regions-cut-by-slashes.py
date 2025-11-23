class Solution:
    def regionsBySlashes(self, grid: List[str]) -> int:
        n = len(grid)
        parent = [i for i in range((n + 1) * (n + 1))]

        def find(x):
            if parent[x] != x:
                parent[x] = find(parent[x])
            return parent[x]

        def union(x, y):
            rootX = find(x)
            rootY = find(y)
            if rootX != rootY:
                parent[rootX] = rootY

        for i in range(n):
            for j in range(n):
                if grid[i][j] == ' ':
                    union(i * (n + 1) + j, (i + 1) * (n + 1) + j)
                    union(i * (n + 1) + j, i * (n + 1) + j + 1)
                elif grid[i][j] == '/':
                    union(i * (n + 1) + j + 1, (i + 1) * (n + 1) + j)
                elif grid[i][j] == '\\':
                    union(i * (n + 1) + j, (i + 1) * (n + 1) + j + 1)

        return sum(find(i) == i for i in range((n + 1) * (n + 1)))