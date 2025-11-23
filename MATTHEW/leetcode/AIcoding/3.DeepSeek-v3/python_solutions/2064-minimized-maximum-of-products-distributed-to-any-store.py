class Solution:
    def minimizedMaximum(self, n: int, quantities: List[int]) -> int:
        left, right = 1, max(quantities)

        def canDistribute(mid):
            total = 0
            for q in quantities:
                total += (q + mid - 1) // mid
                if total > n:
                    return False
            return True

        while left < right:
            mid = (left + right) // 2
            if canDistribute(mid):
                right = mid
            else:
                left = mid + 1
        return left