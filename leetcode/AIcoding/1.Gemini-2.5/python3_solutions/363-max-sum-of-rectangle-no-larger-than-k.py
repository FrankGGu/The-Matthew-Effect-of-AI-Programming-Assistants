import math
from sortedcontainers import SortedList

class Solution:
    def maxSumSubmatrix(self, matrix: list[list[int]], k: int) -> int:
        rows = len(matrix)
        cols = len(matrix[0])
        max_sum = -math.inf

        for r1 in range(rows):
            col_sums = [0] * cols
            for r2 in range(r1, rows):
                for c in range(cols):
                    col_sums[c] += matrix[r2][c]

                current_rect_max_sum = self._max_subarray_sum_no_larger_than_k(col_sums, k)
                max_sum = max(max_sum, current_rect_max_sum)
                if max_sum == k:
                    return k
        return max_sum

    def _max_subarray_sum_no_larger_than_k(self, arr: list[int], k: int) -> int:
        current_sum = 0
        max_so_far = -math.inf

        prefix_sums = SortedList([0]) 

        for num in arr:
            current_sum += num

            idx = prefix_sums.bisect_left(current_sum - k)

            if idx < len(prefix_sums):
                max_so_far = max(max_so_far, current_sum - prefix_sums[idx])

            prefix_sums.add(current_sum)

        return max_so_far