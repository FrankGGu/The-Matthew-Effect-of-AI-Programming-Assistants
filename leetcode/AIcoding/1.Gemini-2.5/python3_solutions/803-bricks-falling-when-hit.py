class DSU:
    def __init__(self, n):
        self.parent = list(range(n))
        self.size = [1] * n

    def find(self, i):
        if self.parent[i] == i:
            return i
        self.parent[i] = self.find(self.parent[i])
        return self.parent[i]

    def union(self, i, j):
        root_i = self.find(i)
        root_j = self.find(j)
        if root_i != root_j:
            if self.size[root_i] < self.size[root_j]:
                root_i, root_j = root_j, root_i
            self.parent[root_j] = root_i
            self.size[root_i] += self.size[root_j]
            return True
        return False

class Solution:
    def hitBricks(self, grid: list[list[int]], hits: list[list[int]]) -> list[int]:
        R = len(grid)
        C = len(grid[0])

        curr_grid = [row[:] for row in grid]
        hits_original_values = []
        for r, c in hits:
            hits_original_values.append(curr_grid[r][c])
            curr_grid[r][c] = 0

        dsu = DSU(R * C + 1)
        ceiling_node_idx = R * C

        dr = [-1, 1, 0, 0]
        dc = [0, 0, -1, 1]

        for r in range(R):
            for c in range(C):
                if curr_grid[r][c] == 1:
                    idx = r * C + c
                    if r == 0:
                        dsu.union(idx, ceiling_node_idx)
                    for i in range(4):
                        nr, nc = r + dr[i], c + dc[i]
                        if 0 <= nr < R and 0 <= nc < C and curr_grid[nr][nc] == 1:
                            n_idx = nr * C + nc
                            dsu.union(idx, n_idx)

        results = [0] * len(hits)
        for i in range(len(hits) - 1, -1, -1):
            r, c = hits[i]
            original_val = hits_original_values[i]

            if original_val == 0:
                results[i] = 0
                continue

            prev_stable_count = dsu.size[dsu.find(ceiling_node_idx)] - 1

            curr_grid[r][c] = 1
            idx = r * C + c

            if r == 0:
                dsu.union(idx, ceiling_node_idx)
            for k in range(4):
                nr, nc = r + dr[k], c + dc[k]
                if 0 <= nr < R and 0 <= nc < C and curr_grid[nr][nc] == 1:
                    n_idx = nr * C + nc
                    dsu.union(idx, n_idx)

            curr_stable_count = dsu.size[dsu.find(ceiling_node_idx)] - 1

            fallen_bricks = max(0, curr_stable_count - prev_stable_count - 1)
            results[i] = fallen_bricks

        return results