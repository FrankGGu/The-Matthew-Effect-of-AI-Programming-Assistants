class Solution:
    def largestLocal(self, matrix: List[List[int]]) -> List[List[int]]:
        n = len(matrix)
        result = [[0] * (n - 1) for _ in range(n - 1)]
        for i in range(n - 1):
            for j in range(n - 1):
                max_val = 0
                for x in range(i, i + 2):
                    for y in range(j, j + 2):
                        max_val = max(max_val, matrix[x][y])
                result[i][j] = max_val
        return result