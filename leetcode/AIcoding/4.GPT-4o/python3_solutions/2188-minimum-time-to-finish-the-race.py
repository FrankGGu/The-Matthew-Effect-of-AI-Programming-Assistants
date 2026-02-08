from typing import List

class Solution:
    def minimumFinishTime(self, tires: List[List[int]], changeTime: int, numLaps: int) -> int:
        max_laps = numLaps + 1
        dp = [float('inf')] * max_laps
        dp[0] = 0

        for tire in tires:
            time, cost = tire
            lap_time = time
            total_time = time
            for lap in range(1, max_laps):
                if total_time > changeTime + 1e9: 
                    break
                dp[lap] = min(dp[lap], total_time + dp[lap - 1])
                lap_time *= cost
                total_time += lap_time

        for lap in range(1, max_laps):
            dp[lap] = min(dp[lap], dp[lap - 1] + changeTime)

        return dp[numLaps]