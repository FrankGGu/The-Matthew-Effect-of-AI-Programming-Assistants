class Solution:
    def findPeakGrid(self, mat: List[List[int]]) -> List[int]:
        m, n = len(mat), len(mat[0])

        def is_peak(row, col):
            val = mat[row][col]
            if row > 0 and mat[row-1][col] > val:
                return False
            if row < m - 1 and mat[row+1][col] > val:
                return False
            if col > 0 and mat[row][col-1] > val:
                return False
            if col < n - 1 and mat[row][col+1] > val:
                return False
            return True

        left, right = 0, n - 1
        while left <= right:
            mid = (left + right) // 2
            max_row = 0
            for i in range(1, m):
                if mat[i][mid] > mat[max_row][mid]:
                    max_row = i

            if is_peak(max_row, mid):
                return [max_row, mid]

            if mid > 0 and mat[max_row][mid-1] > mat[max_row][mid]:
                right = mid - 1
            else:
                left = mid + 1