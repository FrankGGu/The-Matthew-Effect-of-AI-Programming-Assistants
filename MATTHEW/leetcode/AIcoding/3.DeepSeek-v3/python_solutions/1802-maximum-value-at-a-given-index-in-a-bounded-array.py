class Solution:
    def maxValue(self, n: int, index: int, maxSum: int) -> int:
        left, right = 1, maxSum
        result = 0

        while left <= right:
            mid = (left + right) // 2
            total = mid
            left_length = index
            right_length = n - index - 1

            # Calculate left sum
            if mid > left_length:
                left_sum = (mid - 1 + mid - left_length) * left_length // 2
            else:
                left_sum = (mid - 1) * mid // 2 + (left_length - mid + 1)

            # Calculate right sum
            if mid > right_length:
                right_sum = (mid - 1 + mid - right_length) * right_length // 2
            else:
                right_sum = (mid - 1) * mid // 2 + (right_length - mid + 1)

            total += left_sum + right_sum

            if total <= maxSum:
                result = mid
                left = mid + 1
            else:
                right = mid - 1

        return result