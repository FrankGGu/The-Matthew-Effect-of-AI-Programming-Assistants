import bisect

class Solution:
    def maxIncreasingCells(self, mat: List[List[int]]) -> int:
        m, n = len(mat), len(mat[0])
        val_pos = defaultdict(list)
        for i in range(m):
            for j in range(n):
                val_pos[mat[i][j]].append((i, j))

        sorted_vals = sorted(val_pos.keys())
        row_max = [0] * m
        col_max = [0] * n
        res = 0

        for val in sorted_vals:
            temp = []
            for i, j in val_pos[val]:
                current_max = max(row_max[i], col_max[j]) + 1
                temp.append((i, j, current_max))
                res = max(res, current_max)
            for i, j, current_max in temp:
                row_max[i] = max(row_max[i], current_max)
                col_max[j] = max(col_max[j], current_max)

        return res