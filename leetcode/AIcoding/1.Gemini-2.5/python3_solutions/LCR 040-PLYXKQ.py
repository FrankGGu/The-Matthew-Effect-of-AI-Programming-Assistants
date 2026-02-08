class Solution:
    def maximalRectangle(self, matrix: list[list[str]]) -> int:
        if not matrix or not matrix[0]:
            return 0

        R = len(matrix)
        C = len(matrix[0])
        max_overall_area = 0
        heights = [0] * C

        for i in range(R):
            for j in range(C):
                if matrix[i][j] == '1':
                    heights[j] += 1
                else:
                    heights[j] = 0

            current_row_max_area = 0
            stack = []

            for k in range(C + 1):
                h = heights[k] if k < C else 0

                while stack and h < heights[stack[-1]]:
                    height_popped = heights[stack.pop()]
                    width = k if not stack else k - stack[-1] - 1
                    current_row_max_area = max(current_row_max_area, height_popped * width)

                stack.append(k)

            max_overall_area = max(max_overall_area, current_row_max_area)

        return max_overall_area