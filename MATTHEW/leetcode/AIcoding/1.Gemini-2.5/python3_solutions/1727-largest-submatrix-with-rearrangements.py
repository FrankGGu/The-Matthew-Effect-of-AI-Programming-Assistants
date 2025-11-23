class Solution:
    def largestSubmatrix(self, matrix: list[list[int]]) -> int:
        m = len(matrix)
        n = len(matrix[0])

        max_area = 0
        current_heights = [0] * n

        for i in range(m):
            for j in range(n):
                if matrix[i][j] == 1:
                    current_heights[j] += 1
                else:
                    current_heights[j] = 0

            # Sort the heights for the current row to find the maximum possible submatrix
            # by rearranging columns.
            # Sorting in descending order allows us to easily calculate area:
            # For a width k+1, the height is at least sorted_heights[k].
            sorted_heights = sorted(current_heights, reverse=True)

            for k in range(n):
                # The width of the submatrix is (k + 1)
                # The height is sorted_heights[k] (because all k+1 columns have at least this height)
                max_area = max(max_area, sorted_heights[k] * (k + 1))

        return max_area