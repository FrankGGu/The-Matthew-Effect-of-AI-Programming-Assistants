class Solution:
    def maxSumSubmatrix(self, matrix, k):
        if not matrix or not matrix[0]:
            return 0

        m, n = len(matrix), len(matrix[0])
        max_sum = float('-inf')

        for left in range(n):
            row_sums = [0] * m
            for right in range(left, n):
                for i in range(m):
                    row_sums[i] += matrix[i][right]

                curr_sum = 0
                sorted_sums = [0]

                for row_sum in row_sums:
                    curr_sum += row_sum

                    from bisect import bisect_left

                    idx = bisect_left(sorted_sums, curr_sum - k)
                    if idx < len(sorted_sums):
                        max_sum = max(max_sum, curr_sum - sorted_sums[idx])

                    from bisect import insort
                    insort(sorted_sums, curr_sum)

        return max_sum