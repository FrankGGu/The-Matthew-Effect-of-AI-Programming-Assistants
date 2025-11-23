import math

class Solution:
    def minimizedMaximum(self, n: int, quantities: list[int]) -> int:

        def check(max_val: int) -> bool:
            stores_needed = 0
            for q in quantities:
                stores_needed += (q + max_val - 1) // max_val
            return stores_needed <= n

        left = 1
        right = max(quantities)

        while left < right:
            mid = (left + right) // 2
            if check(mid):
                right = mid
            else:
                left = mid + 1

        return left