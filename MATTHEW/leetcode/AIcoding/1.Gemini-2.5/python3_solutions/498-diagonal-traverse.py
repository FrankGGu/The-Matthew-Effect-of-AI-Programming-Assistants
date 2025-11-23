class Solution:
    def findDiagonalOrder(self, mat: list[list[int]]) -> list[int]:
        if not mat or not mat[0]:
            return []

        m = len(mat)
        n = len(mat[0])

        diagonals = {}
        for r in range(m):
            for c in range(n):
                s = r + c
                if s not in diagonals:
                    diagonals[s] = []
                diagonals[s].append(mat[r][c])

        result = []
        for s in range(m + n - 1):
            if s % 2 == 0:
                result.extend(diagonals[s][::-1])
            else:
                result.extend(diagonals[s])

        return result