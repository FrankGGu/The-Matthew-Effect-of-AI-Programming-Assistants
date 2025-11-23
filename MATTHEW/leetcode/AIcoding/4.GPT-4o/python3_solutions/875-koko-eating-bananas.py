class Solution:
    def minEatingSpeed(self, piles: List[int], H: int) -> int:
        def canEatAll(speed):
            return sum((pile + speed - 1) // speed for pile in piles) <= H

        left, right = 1, max(piles)
        while left < right:
            mid = (left + right) // 2
            if canEatAll(mid):
                right = mid
            else:
                left = mid + 1
        return left