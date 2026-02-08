class Solution:
    def maximalRectangle(self, matrix: List[List[str]]) -> int:
        if not matrix or not matrix[0]:
            return 0

        rows = len(matrix)
        cols = len(matrix[0])
        heights = [0] * cols
        max_area = 0

        for i in range(rows):
            for j in range(cols):
                if matrix[i][j] == '1':
                    heights[j] += 1
                else:
                    heights[j] = 0

            stack = []
            for k in range(cols + 1):
                h = heights[k] if k < cols else 0
                while stack and h < heights[stack[-1]]:
                    height = heights[stack.pop()]
                    width = k if not stack else k - stack[-1] - 1
                    max_area = max(max_area, height * width)
                stack.append(k)

        return max_area