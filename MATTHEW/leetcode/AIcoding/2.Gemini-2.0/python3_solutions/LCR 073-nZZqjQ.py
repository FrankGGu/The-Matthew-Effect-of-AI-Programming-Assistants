class Solution:
    def minEatingSpeed(self, piles: list[int], h: int) -> int:
        l, r = 1, max(piles)
        while l < r:
            mid = (l + r) // 2
            hours = 0
            for pile in piles:
                hours += (pile + mid - 1) // mid
            if hours > h:
                l = mid + 1
            else:
                r = mid
        return l