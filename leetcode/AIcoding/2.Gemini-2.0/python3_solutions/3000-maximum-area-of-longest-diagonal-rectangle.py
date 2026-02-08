import math

class Solution:
    def areaOfMaxDiagonal(self, dimensions: list[list[int]]) -> int:
        max_diagonal = 0
        max_area = 0
        for l, w in dimensions:
            diagonal = math.sqrt(l * l + w * w)
            area = l * w
            if diagonal > max_diagonal:
                max_diagonal = diagonal
                max_area = area
            elif diagonal == max_diagonal:
                max_area = max(max_area, area)
        return max_area