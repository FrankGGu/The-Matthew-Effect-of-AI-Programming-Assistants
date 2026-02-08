class Solution:
    def longestVShapedDiagonal(self, matrix: List[List[int]]) -> int:
        if not matrix or not matrix[0]:
            return 0

        n, m = len(matrix), len(matrix[0])
        max_length = 0

        for i in range(n):
            for j in range(m):
                length = 1
                x, y = i, j

                while x + 1 < n and y + 1 < m and matrix[x + 1][y + 1] < matrix[x][y]:
                    x += 1
                    y += 1
                    length += 1

                x, y = i, j

                while x + 1 < n and y - 1 >= 0 and matrix[x + 1][y - 1] < matrix[x][y]:
                    x += 1
                    y -= 1
                    length += 1

                max_length = max(max_length, length)

        return max_length