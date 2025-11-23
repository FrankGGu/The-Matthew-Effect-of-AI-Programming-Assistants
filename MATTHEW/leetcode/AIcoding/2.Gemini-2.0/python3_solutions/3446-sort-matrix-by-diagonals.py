class Solution:
    def diagonalSort(self, mat: List[List[int]]) -> List[List[int]]:
        m, n = len(mat), len(mat[0])
        diagonals = {}
        for i in range(m):
            for j in range(n):
                if i - j not in diagonals:
                    diagonals[i - j] = []
                diagonals[i - j].append(mat[i][j])

        for k in diagonals:
            diagonals[k].sort()

        for i in range(m):
            for j in range(n):
                mat[i][j] = diagonals[i - j].pop(0)

        return mat