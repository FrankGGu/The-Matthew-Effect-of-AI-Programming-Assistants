class Solution:
    def snakeMatrix(self, matrix):
        if not matrix or not matrix[0]:
            return []

        m, n = len(matrix), len(matrix[0])
        result = []
        for i in range(m + n - 1):
            if i % 2 == 0:
                x = min(i, m - 1)
                y = i - x
                while x >= 0 and y < n:
                    result.append(matrix[x][y])
                    x -= 1
                    y += 1
            else:
                y = min(i, n - 1)
                x = i - y
                while y >= 0 and x < m:
                    result.append(matrix[x][y])
                    x += 1
                    y -= 1
        return result