class Solution:
    def hitBricks(self, grid: List[List[int]], hits: List[List[int]]) -> List[int]:
        rows, cols = len(grid), len(grid[0])

        def index(r, c):
            return r * cols + c

        parent = [i for i in range(rows * cols + 1)]
        size = [1] * (rows * cols + 1)

        def find(u):
            while parent[u] != u:
                parent[u] = parent[parent[u]]
                u = parent[u]
            return u

        def union(u, v):
            u_root = find(u)
            v_root = find(v)
            if u_root == v_root:
                return
            if u_root < v_root:
                parent[v_root] = u_root
                size[u_root] += size[v_root]
            else:
                parent[u_root] = v_root
                size[v_root] += size[u_root]

        for r, c in hits:
            if grid[r][c] == 1:
                grid[r][c] = 2

        for r in range(rows):
            for c in range(cols):
                if grid[r][c] == 1:
                    i = index(r, c)
                    if r == 0:
                        union(i, rows * cols)
                    if r > 0 and grid[r-1][c] == 1:
                        union(i, index(r-1, c))
                    if c > 0 and grid[r][c-1] == 1:
                        union(i, index(r, c-1))

        directions = [(-1, 0), (1, 0), (0, -1), (0, 1)]
        res = []
        for r, c in reversed(hits):
            if grid[r][c] == 2:
                grid[r][c] = 1
                i = index(r, c)
                origin = size[find(rows * cols)]
                if r == 0:
                    union(i, rows * cols)
                for dr, dc in directions:
                    nr, nc = r + dr, c + dc
                    if 0 <= nr < rows and 0 <= nc < cols and grid[nr][nc] == 1:
                        union(i, index(nr, nc))
                current = size[find(rows * cols)]
                res.append(max(0, current - origin - 1))
            else:
                res.append(0)

        return res[::-1]