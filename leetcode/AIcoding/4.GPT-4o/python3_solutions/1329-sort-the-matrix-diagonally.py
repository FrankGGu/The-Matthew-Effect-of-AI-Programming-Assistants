class Solution:
    def diagonalSort(self, mat: List[List[int]]) -> List[List[int]]:
        from collections import defaultdict

        diagonals = defaultdict(list)
        rows, cols = len(mat), len(mat[0])

        for r in range(rows):
            for c in range(cols):
                diagonals[r - c].append(mat[r][c])

        for key in diagonals:
            diagonals[key].sort()

        for r in range(rows):
            for c in range(cols):
                mat[r][c] = diagonals[r - c].pop(0)

        return mat