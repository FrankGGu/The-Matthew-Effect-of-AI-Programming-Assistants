class Solution:
    def minimumTime(self, time: List[int], totalTrips: int) -> int:
        left = 1
        right = max(time) * totalTrips

        def canComplete(tripTime):
            return sum(tripTime // t for t in time) >= totalTrips

        while left < right:
            mid = (left + right) // 2
            if canComplete(mid):
                right = mid
            else:
                left = mid + 1

        return left