class Solution:
    def matrixRankTransform(self, matrix: list[list[int]]) -> list[list[int]]:
        R, C = len(matrix), len(matrix[0])

        cells = []
        for r in range(R):
            for c in range(C):
                cells.append((matrix[r][c], r, c))

        cells.sort()

        ans = [[0] * C for _ in range(R)]
        row_max_rank = [0] * R
        col_max_rank = [0] * C

        def find(parent, i):
            if parent[i] == i:
                return i
            parent[i] = find(parent, parent[i])
            return parent[i]

        i = 0
        while i < len(cells):
            j = i
            while j < len(cells) and cells[j][0] == cells[i][0]:
                j += 1

            current_value_group = cells[i:j]

            parent = list(range(R + C)) 

            for _, r, c in current_value_group:
                root_r = find(parent, r)
                root_c = find(parent, R + c)
                if root_r != root_c:
                    parent[root_c] = root_r

            component_max_prev_rank = {}
            for _, r, c in current_value_group:
                root = find(parent, r)
                component_max_prev_rank[root] = max(component_max_prev_rank.get(root, 0),
                                                    row_max_rank[r],
                                                    col_max_rank[c])

            for _, r, c in current_value_group:
                root = find(parent, r)
                rank = component_max_prev_rank[root] + 1
                ans[r][c] = rank

                row_max_rank[r] = max(row_max_rank[r], rank)
                col_max_rank[c] = max(col_max_rank[c], rank)

            i = j

        return ans