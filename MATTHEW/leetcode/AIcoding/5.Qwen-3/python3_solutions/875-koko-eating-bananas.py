class Solution:
    def minEatingSpeed(self, piles: List[int], h: int) -> int:
        left, right = 1, max(piles)

        def canEat(k):
            hours = 0
            for pile in piles:
                hours += (pile + k - 1) // k
                if hours > h:
                    return False
            return True

        while left < right:
            mid = (left + right) // 2
            if canEat(mid):
                right = mid
            else:
                left = mid + 1
        return left