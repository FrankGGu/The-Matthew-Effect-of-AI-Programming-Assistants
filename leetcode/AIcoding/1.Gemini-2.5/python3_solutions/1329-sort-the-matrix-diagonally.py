import collections

class Solution:
    def diagonalSort(self, mat: list[list[int]]) -> list[list[int]]:
        m = len(mat)
        n = len(mat[0])

        diagonals = collections.defaultdict(list)

        for r in range(m):
            for c in range(n):
                diagonals[r - c].append(mat[r][c])

        for k in diagonals:
            diagonals[k].sort()
            diagonals[k] = collections.deque(diagonals[k])

        for r in range(m):
            for c in range(n):
                mat[r][c] = diagonals[r - c].popleft()

        return mat