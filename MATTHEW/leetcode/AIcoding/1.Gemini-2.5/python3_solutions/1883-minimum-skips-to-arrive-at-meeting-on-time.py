import math

class Solution:
    def minSkips(self, dist: list[int], speed: int, hoursBefore: int) -> int:
        n = len(dist)
        # dp[i][j] will store the minimum time to complete the first i+1 roads (roads 0 to i)
        # using exactly j skips.
        # i goes from 0 to n-1 (road index)
        # j goes from 0 to n (number of skips)
        dp = [[float('inf')] * (n + 1) for _ in range(n)]

        # Base case: Road 0
        # Option 1: Don't skip road 0 (j=0 skips)
        # If n == 1, it's the last road, so no rounding up.
        # If n > 1, it's not the last road, so must round up.
        if n == 1:
            dp[0][0] = dist[0] / speed
        else:
            dp[0][0] = math.ceil(dist[0] / speed)

        # Option 2: Skip road 0 (j=1 skips)
        # No rounding up for a skipped road.
        # This is only possible if n >= 1 (guaranteed by constraints) and we have a skip available.
        # For road 0 (i=0), the maximum number of skips we could have used is 1.
        dp[0][1] = dist[0] / speed

        # Fill DP table for roads 1 to n-1
        for i in range(1, n):
            # j can go up to i+1 (all roads up to i skipped), but max total skips is n.
            # So, j ranges from 0 to min(i + 1, n). Using n + 1 as upper bound is safe.
            for j in range(n + 1): 

                # Option 1: Don't skip current road 'i'
                # This means we used 'j' skips to reach the end of road 'i-1'.
                if dp[i-1][j] != float('inf'):
                    time_before_current_road = dp[i-1][j]
                    time_for_current_road_segment = dist[i] / speed
                    total_time_before_rounding = time_before_current_road + time_for_current_road_segment

                    if i < n - 1: # Not the last road, must round up
                        dp[i][j] = min(dp[i][j], math.ceil(total_time_before_rounding))
                    else: # Last road, no rounding
                        dp[i][j] = min(dp[i][j], total_time_before_rounding)

                # Option 2: Skip current road 'i'
                # This means we used 'j-1' skips to reach the end of road 'i-1',
                # and we are using the j-th skip on road 'i'.
                if j > 0 and dp[i-1][j-1] != float('inf'):
                    time_before_current_road = dp[i-1][j-1]
                    time_for_current_road_segment = dist[i] / speed
                    total_time_without_rounding = time_before_current_road + time_for_current_road_segment
                    dp[i][j] = min(dp[i][j], total_time_without_rounding)

        # Find the minimum number of skips required to arrive on time
        for j in range(n + 1):
            if dp[n-1][j] <= hoursBefore:
                return j

        return -1