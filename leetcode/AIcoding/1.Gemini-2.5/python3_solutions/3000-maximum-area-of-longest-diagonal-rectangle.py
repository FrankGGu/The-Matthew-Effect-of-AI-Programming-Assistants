class Solution:
    def maximumArea(self, dimensions: list[list[int]]) -> int:
        max_diag_sq = 0
        max_area = 0

        for length, width in dimensions:
            current_diag_sq = length * length + width * width
            current_area = length * width

            if current_diag_sq > max_diag_sq:
                max_diag_sq = current_diag_sq
                max_area = current_area
            elif current_diag_sq == max_diag_sq:
                max_area = max(max_area, current_area)

        return max_area