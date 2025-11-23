class Solution:
    def rowAndMaximumOnes(self, mat: List[List[int]]) -> List[int]:
        max_ones = -1
        max_row = -1
        for i in range(len(mat)):
            ones = sum(mat[i])
            if ones > max_ones:
                max_ones = ones
                max_row = i
        if max_row == -1:
            return [0, 0]
        return [max_row, max_ones]