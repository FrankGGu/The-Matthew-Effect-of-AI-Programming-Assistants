class Solution:
    def rangeAddQueries(self, n: int, queries: List[List[int]]) -> List[List[int]]:
        matrix = [[0] * n for _ in range(n)]
        for q in queries:
            r1, c1, r2, c2 = q
            for i in range(r1, r2 + 1):
                matrix[i][c1] += 1
                if c2 + 1 < n:
                    matrix[i][c2 + 1] -= 1
        for i in range(n):
            for j in range(1, n):
                matrix[i][j] += matrix[i][j - 1]
        return matrix