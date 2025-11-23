import math

class Solution:
    def minEatingSpeed(self, piles: list[int], h: int) -> int:
        def can_finish(k: int) -> bool:
            hours_needed = 0
            for pile in piles:
                hours_needed += (pile + k - 1) // k
            return hours_needed <= h

        left = 1
        right = max(piles)
        ans = right

        while left <= right:
            mid = (left + right) // 2
            if can_finish(mid):
                ans = mid
                right = mid - 1
            else:
                left = mid + 1

        return ans