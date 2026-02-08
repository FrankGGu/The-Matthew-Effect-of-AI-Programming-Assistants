class Solution:
    def construct2DArray(self, m: int, n: int, graph: list[list[int]]) -> list[list[int]]:
        adj = [[] for _ in range(m * n)]
        for u, v in graph:
            adj[u].append(v)
            adj[v].append(u)

        grid = [[-1] * n for _ in range(m)]
        color = [-1] * (m * n)

        def is_safe(node, c, row, col):
            for neighbor in adj[node]:
                r = neighbor // n
                cc = neighbor % n
                if grid[r][cc] == c:
                    return False
            return True

        def solve(node):
            row = node // n
            col = node % n
            if node == m * n:
                return True

            if grid[row][col] != -1:
                return solve(node + 1)

            for c in range(4):
                if is_safe(node, c, row, col):
                    grid[row][col] = c
                    if solve(node + 1):
                        return True
                    grid[row][col] = -1
            return False

        solve(0)
        return grid