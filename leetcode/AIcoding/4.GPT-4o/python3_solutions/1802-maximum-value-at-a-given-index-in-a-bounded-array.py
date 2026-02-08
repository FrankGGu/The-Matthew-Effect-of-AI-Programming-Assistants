class Solution:
    def maxValue(self, n: int, index: int, maxSum: int) -> int:
        def canAllocate(x):
            left = max(0, index - (x - 1))
            right = max(0, n - 1 - index - (x - 1))
            total = x * (x + 1) // 2 - 1
            total += (x - 1) * left + (x - 1) * right
            return total <= maxSum

        low, high = 1, maxSum
        while low < high:
            mid = (low + high + 1) // 2
            if canAllocate(mid):
                low = mid
            else:
                high = mid - 1
        return low