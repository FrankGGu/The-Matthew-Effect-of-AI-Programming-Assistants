class Solution:
    def minimumTime(self, time: List[int], totalTrips: int) -> int:
        left, right = 1, min(time) * totalTrips

        while left < right:
            mid = (left + right) // 2
            trips = sum(mid // t for t in time)

            if trips >= totalTrips:
                right = mid
            else:
                left = mid + 1

        return left