class Solution:
    def findPeakGrid(self, mat: List[List[int]]) -> List[int]:
        left, right = 0, len(mat[0]) - 1
        while left <= right:
            mid = (left + right) // 2
            max_row = 0
            for i in range(len(mat)):
                if mat[i][mid] > mat[max_row][mid]:
                    max_row = i
            if (mid == 0 or mat[max_row][mid] > mat[max_row][mid - 1]) and (mid == len(mat[0]) - 1 or mat[max_row][mid] > mat[max_row][mid + 1]):
                return [max_row, mid]
            elif mid > 0 and mat[max_row][mid - 1] > mat[max_row][mid]:
                right = mid - 1
            else:
                left = mid + 1
        return [-1, -1]