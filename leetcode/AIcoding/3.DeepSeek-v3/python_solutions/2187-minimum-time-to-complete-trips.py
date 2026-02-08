class Solution:
    def minimumTime(self, time: List[int], totalTrips: int) -> int:
        left = 1
        right = max(time) * totalTrips

        def canComplete(t):
            trips = 0
            for bus in time:
                trips += t // bus
                if trips >= totalTrips:
                    return True
            return trips >= totalTrips

        while left < right:
            mid = (left + right) // 2
            if canComplete(mid):
                right = mid
            else:
                left = mid + 1
        return left