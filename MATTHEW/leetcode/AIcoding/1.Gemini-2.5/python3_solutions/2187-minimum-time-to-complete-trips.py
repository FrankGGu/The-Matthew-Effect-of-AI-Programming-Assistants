class Solution:
    def minimumTime(self, time: list[int], totalTrips: int) -> int:

        def check(t: int) -> bool:
            trips_completed = 0
            for bus_time in time:
                trips_completed += t // bus_time
            return trips_completed >= totalTrips

        low = 1
        high = max(time) * totalTrips
        ans = high

        while low <= high:
            mid = low + (high - low) // 2
            if check(mid):
                ans = mid
                high = mid - 1
            else:
                low = mid + 1

        return ans