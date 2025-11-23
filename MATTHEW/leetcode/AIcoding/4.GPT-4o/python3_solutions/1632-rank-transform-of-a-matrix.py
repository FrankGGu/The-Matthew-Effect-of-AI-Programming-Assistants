class Solution:
    def matrixRankTransform(self, matrix: List[List[int]]) -> List[List[int]]:
        from collections import defaultdict
        import numpy as np

        if not matrix or not matrix[0]:
            return []

        rows, cols = len(matrix), len(matrix[0])
        ans = [[0] * cols for _ in range(rows)]
        value_to_index = defaultdict(list)

        for r in range(rows):
            for c in range(cols):
                value_to_index[matrix[r][c]].append((r, c))

        rank = np.zeros((rows, cols), dtype=int)

        for value in sorted(value_to_index.keys()):
            for r, c in value_to_index[value]:
                rank[r][c] = max(rank[r]) if rank[r].any() else 0

            for r, c in value_to_index[value]:
                rank[r][c] = max(rank[r][c], max(rank[:, c]) if rank[:, c].any() else 0) + 1

            for r, c in value_to_index[value]:
                ans[r][c] = rank[r][c]

        return ans