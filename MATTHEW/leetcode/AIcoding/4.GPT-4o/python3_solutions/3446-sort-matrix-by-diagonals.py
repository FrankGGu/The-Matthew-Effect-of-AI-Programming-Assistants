from collections import defaultdict
import heapq

class Solution:
    def diagonalSort(self, mat: List[List[int]]) -> List[List[int]]:
        if not mat:
            return mat

        diagonals = defaultdict(list)
        m, n = len(mat), len(mat[0])

        for i in range(m):
            for j in range(n):
                diagonals[i - j].append(mat[i][j])

        for diag in diagonals:
            diagonals[diag].sort()

        result = [[0] * n for _ in range(m)]

        for i in range(m):
            for j in range(n):
                result[i][j] = diagonals[i - j].pop(0)

        return result