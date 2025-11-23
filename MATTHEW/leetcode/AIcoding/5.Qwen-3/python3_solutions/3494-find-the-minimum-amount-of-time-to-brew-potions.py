from typing import List

class Solution:
    def minimumTime(self, time: List[int], totalTrips: int) -> int:
        left = 0
        right = max(time) * totalTrips

        def canComplete(trips):
            total = 0
            for t in time:
                total += trips // t
                if total >= totalTrips:
                    return True
            return False

        while left < right:
            mid = (left + right) // 2
            if canComplete(mid):
                right = mid
            else:
                left = mid + 1

        return left