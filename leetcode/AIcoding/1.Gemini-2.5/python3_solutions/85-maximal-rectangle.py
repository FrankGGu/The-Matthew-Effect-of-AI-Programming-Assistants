class Solution:
    def maximalRectangle(self, matrix: list[list[str]]) -> int:
        if not matrix or not matrix[0]:
            return 0

        m = len(matrix)
        n = len(matrix[0])
        max_area = 0
        heights = [0] * n

        def calculate_max_area_histogram(h_arr: list[int]) -> int:
            stack = []  # Stores indices
            current_max_area = 0

            for i in range(len(h_arr) + 1):
                current_h = h_arr[i] if i < len(h_arr) else 0 # Sentinel height 0 at the end

                while stack and current_h < h_arr[stack[-1]]:
                    height = h_arr[stack.pop()]
                    width = i if not stack else i - stack[-1] - 1
                    current_max_area = max(current_max_area, height * width)
                stack.append(i)
            return current_max_area

        for i in range(m):
            for j in range(n):
                if matrix[i][j] == '1':
                    heights[j] += 1
                else:
                    heights[j] = 0

            max_area = max(max_area, calculate_max_area_histogram(heights))

        return max_area