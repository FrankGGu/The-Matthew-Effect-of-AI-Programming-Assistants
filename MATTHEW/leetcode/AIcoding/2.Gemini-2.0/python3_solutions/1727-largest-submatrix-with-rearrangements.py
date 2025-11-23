class Solution:
    def largestSubmatrix(self, matrix: List[List[int]]) -> int:
        m = len(matrix)
        n = len(matrix[0])
        heights = [0] * n
        max_area = 0

        for i in range(m):
            for j in range(n):
                if matrix[i][j] == 1:
                    heights[j] += 1
                else:
                    heights[j] = 0

            sorted_heights = sorted(heights, reverse=True)

            for j in range(n):
                max_area = max(max_area, sorted_heights[j] * (j + 1))

        return max_area