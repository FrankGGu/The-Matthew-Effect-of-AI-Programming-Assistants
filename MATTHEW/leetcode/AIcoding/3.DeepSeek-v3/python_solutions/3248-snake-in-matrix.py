class Solution:
    def findDiagonalOrder(self, matrix: List[List[int]]) -> List[int]:
        if not matrix or not matrix[0]:
            return []

        m, n = len(matrix), len(matrix[0])
        result = []
        direction = 1  # 1 for upwards, -1 for downwards
        i, j = 0, 0

        for _ in range(m * n):
            result.append(matrix[i][j])

            if direction == 1:
                if j == n - 1:
                    i += 1
                    direction = -1
                elif i == 0:
                    j += 1
                    direction = -1
                else:
                    i -= 1
                    j += 1
            else:
                if i == m - 1:
                    j += 1
                    direction = 1
                elif j == 0:
                    i += 1
                    direction = 1
                else:
                    i += 1
                    j -= 1

        return result