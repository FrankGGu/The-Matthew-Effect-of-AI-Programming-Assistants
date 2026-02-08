class Solution:
    def rangeAddQueries(self, n: int, queries: List[List[int]]) -> List[List[int]]:
        matrix = [[0] * n for _ in range(n)]
        for x1, y1, x2, y2 in queries:
            matrix[x1][y1] += 1
            if x2 + 1 < n:
                matrix[x2 + 1][y1] -= 1
            if y2 + 1 < n:
                matrix[x1][y2 + 1] -= 1
            if x2 + 1 < n and y2 + 1 < n:
                matrix[x2 + 1][y2 + 1] += 1

        for i in range(n):
            for j in range(1, n):
                matrix[i][j] += matrix[i][j - 1]

        for j in range(n):
            for i in range(1, n):
                matrix[i][j] += matrix[i - 1][j]

        return matrix