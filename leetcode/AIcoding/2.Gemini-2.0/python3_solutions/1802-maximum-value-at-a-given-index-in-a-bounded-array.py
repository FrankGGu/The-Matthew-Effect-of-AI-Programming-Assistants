class Solution:
    def maxValue(self, n: int, index: int, maxSum: int) -> int:
        def check(val):
            left_sum = 0
            right_sum = 0

            if val > index:
                left_sum = (val + val - index) * (index + 1) // 2
            else:
                left_sum = (val + 1) * val // 2 + index - val + 1

            if val >= n - index:
                right_sum = (val + val - (n - index - 1)) * (n - index) // 2
            else:
                right_sum = (val + 1) * val // 2 + (n - index - 1) - val + 1

            return left_sum + right_sum - val

        left = 1
        right = maxSum

        while left < right:
            mid = (left + right + 1) // 2
            if check(mid) <= maxSum:
                left = mid
            else:
                right = mid - 1

        return left