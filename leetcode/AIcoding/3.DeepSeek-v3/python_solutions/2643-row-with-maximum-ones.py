class Solution:
    def rowAndMaximumOnes(self, mat: List[List[int]]) -> List[int]:
        max_count = -1
        max_row = 0
        for i in range(len(mat)):
            current_count = sum(mat[i])
            if current_count > max_count or (current_count == max_count and i < max_row):
                max_count = current_count
                max_row = i
        return [max_row, max_count]