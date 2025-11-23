class Solution:
    def areaOfMaxDiagonal(self, dimensions: List[List[int]]) -> int:
        max_diag = 0
        max_area = 0
        for l, w in dimensions:
            diag = l * l + w * w
            if diag > max_diag:
                max_diag = diag
                max_area = l * w
            elif diag == max_diag:
                if l * w > max_area:
                    max_area = l * w
        return max_area