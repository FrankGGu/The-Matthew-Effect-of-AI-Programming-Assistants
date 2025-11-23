import bisect

class Solution:
    def kthSmallest(self, matrix: list[list[int]], k: int) -> int:
        n_rows = len(matrix)
        n_cols = len(matrix[0])

        low = matrix[0][0]
        high = matrix[n_rows - 1][n_cols - 1]
        ans = high

        while low <= high:
            mid = low + (high - low) // 2

            count = 0
            for r in range(n_rows):
                # bisect_right returns an insertion point which is also the count
                # of elements in matrix[r] that are less than or equal to mid.
                count += bisect.bisect_right(matrix[r], mid)

            if count < k:
                # If there are fewer than k elements less than or equal to mid,
                # then the kth smallest element must be greater than mid.
                low = mid + 1
            else:
                # If there are k or more elements less than or equal to mid,
                # then mid could be the kth smallest element. We store it as a
                # potential answer and try to find a smaller one.
                ans = mid
                high = mid - 1

        return ans