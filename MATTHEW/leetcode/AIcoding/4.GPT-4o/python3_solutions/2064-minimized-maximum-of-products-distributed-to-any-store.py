class Solution:
    def minimizedMaximum(self, n: int, quantities: List[int]) -> int:
        def canDistribute(maximum):
            total = 0
            for q in quantities:
                total += (q + maximum - 1) // maximum
            return total <= n

        left, right = 1, max(quantities)
        while left < right:
            mid = (left + right) // 2
            if canDistribute(mid):
                right = mid
            else:
                left = mid + 1
        return left