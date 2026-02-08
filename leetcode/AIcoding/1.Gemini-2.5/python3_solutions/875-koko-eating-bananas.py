import math

class Solution:
    def minEatingSpeed(self, piles: list[int], h: int) -> int:
        left = 1
        right = max(piles)
        ans = right

        while left <= right:
            mid = (left + right) // 2

            hours_needed = 0
            for pile in piles:
                hours_needed += math.ceil(pile / mid)

            if hours_needed <= h:
                ans = mid
                right = mid - 1
            else:
                left = mid + 1

        return ans