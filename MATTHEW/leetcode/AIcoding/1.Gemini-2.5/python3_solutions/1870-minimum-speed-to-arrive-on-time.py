import math

class Solution:
    def minSpeedOnTime(self, dist: list[int], hour: float) -> int:
        n = len(dist)

        # If there's more than one train ride, and the target hour is less than or equal to
        # the number of rides minus one, it's impossible.
        # This is because each of the first n-1 rides takes at least 1 hour (due to math.ceil),
        # even with infinite speed, resulting in at least n-1 hours.
        # The last ride will take some positive time.
        # So, total time will always be strictly greater than n-1.
        if n > 1 and hour <= n - 1:
            return -1

        # Binary search for the minimum integer speed
        low = 1
        # A sufficiently large upper bound for speed.
        # In the worst case, if hour is barely greater than n-1 (e.g., n-1 + 10^-9)
        # and the last distance is large (10^5), speed could be 10^5 / 10^-9 = 10^14.
        high = 10**14 

        ans = -1

        while low <= high:
            mid_speed = low + (high - low) // 2

            current_total_time = 0.0

            # Calculate time for the first n-1 segments
            for i in range(n - 1):
                current_total_time += math.ceil(dist[i] / mid_speed)

            # Add time for the last segment (no waiting time)
            current_total_time += dist[n-1] / mid_speed

            if current_total_time <= hour:
                # If this speed works, it's a possible answer.
                # Try for a smaller speed.
                ans = mid_speed
                high = mid_speed - 1
            else:
                # This speed is too slow, need to increase speed.
                low = mid_speed + 1

        return ans