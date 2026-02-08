class Solution:
    def maximumRows(self, mat: List[List[int]], cols: int) -> int:
        m, n = len(mat), len(mat[0])
        max_rows = 0

        def backtrack(start, selected):
            nonlocal max_rows
            if len(selected) == cols:
                covered = 0
                for i in range(m):
                    covered_row = True
                    for j in range(n):
                        if mat[i][j] == 1 and j not in selected:
                            covered_row = False
                            break
                    if covered_row:
                        covered += 1
                max_rows = max(max_rows, covered)
                return

            for j in range(start, n):
                selected.add(j)
                backtrack(j + 1, selected)
                selected.remove(j)

        backtrack(0, set())
        return max_rows