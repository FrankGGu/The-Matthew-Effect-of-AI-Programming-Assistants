import bisect

class Solution:
    def maxSumSubmatrix(self, matrix: List[List[int]], k: int) -> int:
        rows = len(matrix)
        cols = len(matrix[0]) if rows > 0 else 0
        max_sum = -float('inf')

        for left in range(cols):
            row_sum = [0] * rows
            for right in range(left, cols):
                for i in range(rows):
                    row_sum[i] += matrix[i][right]

                prefix_sum = [0]
                current_sum = 0
                for num in row_sum:
                    current_sum += num
                    idx = bisect.bisect_left(prefix_sum, current_sum - k)
                    if idx < len(prefix_sum):
                        max_sum = max(max_sum, current_sum - prefix_sum[idx])
                    bisect.insort(prefix_sum, current_sum)
                    if max_sum == k:
                        return k
        return max_sum