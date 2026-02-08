class Solution:
    def largestSubmatrix(self, matrix: List[List[int]]) -> int:
        if not matrix or not matrix[0]:
            return 0

        rows, cols = len(matrix), len(matrix[0])
        heights = [[0] * cols for _ in range(rows)]

        for j in range(cols):
            for i in range(rows):
                if matrix[i][j] == 1:
                    heights[i][j] = heights[i-1][j] + 1 if i > 0 else 1

        max_area = 0

        for i in range(rows):
            sorted_heights = sorted(heights[i], reverse=True)
            for j in range(cols):
                max_area = max(max_area, sorted_heights[j] * (j + 1))

        return max_area