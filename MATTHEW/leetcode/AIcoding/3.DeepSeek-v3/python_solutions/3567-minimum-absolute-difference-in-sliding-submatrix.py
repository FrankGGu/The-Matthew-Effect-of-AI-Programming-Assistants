import heapq

class Solution:
    def minDifference(self, nums: List[List[int]], k: int) -> int:
        rows = len(nums)
        cols = len(nums[0]) if rows > 0 else 0
        min_diff = float('inf')

        for i in range(rows - k + 1):
            for j in range(cols - k + 1):
                submatrix = []
                for x in range(i, i + k):
                    for y in range(j, j + k):
                        submatrix.append(nums[x][y])
                submatrix.sort()
                current_diff = submatrix[-1] - submatrix[0]
                if current_diff < min_diff:
                    min_diff = current_diff
                if min_diff == 0:
                    return 0
        return min_diff