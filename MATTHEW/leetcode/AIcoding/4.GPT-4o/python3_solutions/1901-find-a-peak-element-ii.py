class Solution:
    def findPeakGrid(self, mat: List[List[int]]) -> List[int]:
        l, r = 0, len(mat[0]) - 1
        while l < len(mat):
            mid = (l + r) // 2
            max_row = max(range(len(mat)), key=lambda x: mat[x][mid])
            if (mid == 0 or mat[max_row][mid] > mat[max_row][mid - 1]) and (mid == len(mat[0]) - 1 or mat[max_row][mid] > mat[max_row][mid + 1]):
                return [max_row, mid]
            elif mid > 0 and mat[max_row][mid] < mat[max_row][mid - 1]:
                r = mid - 1
            else:
                l = mid + 1