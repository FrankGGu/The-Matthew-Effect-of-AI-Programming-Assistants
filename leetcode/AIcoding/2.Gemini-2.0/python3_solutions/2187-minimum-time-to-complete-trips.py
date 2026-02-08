class Solution:
    def minimumTime(self, time: List[int], totalTrips: int) -> int:
        l, r = 1, min(time) * totalTrips
        while l < r:
            mid = (l + r) // 2
            trips = 0
            for t in time:
                trips += mid // t
            if trips >= totalTrips:
                r = mid
            else:
                l = mid + 1
        return l