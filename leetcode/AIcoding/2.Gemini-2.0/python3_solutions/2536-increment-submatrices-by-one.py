class Solution:
    def rangeAddQueries(self, n: int, queries: List[List[int]]) -> List[List[int]]:
        matrix = [[0] * n for _ in range(n)]
        for query in queries:
            row1, col1, row2, col2 = query
            for i in range(row1, row2 + 1):
                for j in range(col1, col2 + 1):
                    matrix[i][j] += 1
        return matrix