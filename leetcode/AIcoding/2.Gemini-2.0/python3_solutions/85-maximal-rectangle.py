class Solution:
    def maximalRectangle(self, matrix: List[List[str]]) -> int:
        if not matrix:
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

            stack = [-1]
            for j in range(cols):
                while stack[-1] != -1 and heights[j] < heights[stack[-1]]:
                    height = heights[stack.pop()]
                    width = j - stack[-1] - 1
                    max_area = max(max_area, height * width)
                stack.append(j)

            while stack[-1] != -1:
                height = heights[stack.pop()]
                width = cols - stack[-1] - 1
                max_area = max(max_area, height * width)

        return max_area