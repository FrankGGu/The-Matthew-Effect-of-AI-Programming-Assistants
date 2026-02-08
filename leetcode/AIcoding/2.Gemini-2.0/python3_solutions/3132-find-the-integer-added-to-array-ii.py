class Solution:
    def findAddedInteger(self, A, B, N):
        sum_A = sum(A)
        sum_B = sum(B)

        left = 0
        right = 2 * 10**9 

        while left <= right:
            mid = left + (right - left) // 2

            if sum_A + mid >= sum_B:
                right = mid - 1
            else:
                left = mid + 1

        return left