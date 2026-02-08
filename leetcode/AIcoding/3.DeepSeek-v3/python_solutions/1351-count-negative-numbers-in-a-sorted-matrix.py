class Solution:
    def countNegatives(self, grid: List[List[int]]) -> int:
        count = 0
        for row in grid:
            left, right = 0, len(row) - 1
            while left <= right:
                mid = (left + right) // 2
                if row[mid] < 0:
                    right = mid - 1
                else:
                    left = mid + 1
            count += len(row) - left
        return count