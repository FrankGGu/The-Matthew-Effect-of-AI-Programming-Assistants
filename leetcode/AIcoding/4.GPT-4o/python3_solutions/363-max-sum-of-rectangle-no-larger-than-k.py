import bisect
import sortedcontainers

class Solution:
    def maxSumSubmatrix(self, matrix: List[List[int]], k: int) -> int:
        if not matrix or not matrix[0]:
            return 0

        rows, cols = len(matrix), len(matrix[0])
        max_sum = float('-inf')

        for left in range(cols):
            sums = [0] * rows
            for right in range(left, cols):
                for r in range(rows):
                    sums[r] += matrix[r][right]

                sorted_sums = sortedcontainers.SortedList([0])
                curr_sum = 0

                for s in sums:
                    curr_sum += s
                    idx = sorted_sums.bisect_left(curr_sum - k)
                    if idx < len(sorted_sums):
                        max_sum = max(max_sum, curr_sum - sorted_sums[idx])
                    sorted_sums.add(curr_sum)

        return max_sum