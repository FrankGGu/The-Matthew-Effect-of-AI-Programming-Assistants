class Solution:
    def minEatingSpeed(self, piles: List[int], H: int) -> int:
        def canEatAll(speed):
            hours = 0
            for pile in piles:
                hours += (pile + speed - 1) // speed
            return hours <= H

        left, right = 1, max(piles)
        while left < right:
            mid = (left + right) // 2
            if canEatAll(mid):
                right = mid
            else:
                left = mid + 1
        return left