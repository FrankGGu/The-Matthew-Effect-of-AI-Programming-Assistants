class Solution:
    def maxIncreasingCells(self, matrix: list[list[int]]) -> int:
        m, n = len(matrix), len(matrix[0])

        cells = []
        for r in range(m):
            for c in range(n):
                cells.append((matrix[r][c], r, c))

        cells.sort()

        row_max_len = [0] * m
        col_max_len = [0] * n

        max_overall_len = 0

        i = 0
        while i < len(cells):
            j = i

            group_updates = [] 

            while j < len(cells) and cells[j][0] == cells[i][0]:
                val, r, c = cells[j]

                current_cell_len = 1 + max(row_max_len[r], col_max_len[c])
                group_updates.append((r, c, current_cell_len))
                j += 1

            for r, c, length in group_updates:
                row_max_len[r] = max(row_max_len[r], length)
                col_max_len[c] = max(col_max_len[c], length)
                max_overall_len = max(max_overall_len, length)

            i = j

        return max_overall_len