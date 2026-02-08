class Solution:
    def minimumFinishTime(self, tires: List[List[int]], changeTime: int, numLaps: int) -> int:
        max_laps_no_change = 18  # Since 2^17 > 1e5, 17 laps max without change
        min_time = [float('inf')] * (max_laps_no_change + 1)

        for f, r in tires:
            total = 0
            time = f
            for lap in range(1, max_laps_no_change + 1):
                total += time
                if total > 1 << 20:  # To prevent overflow and early termination
                    break
                if total < min_time[lap]:
                    min_time[lap] = total
                time *= r

        dp = [float('inf')] * (numLaps + 1)
        dp[0] = 0
        for i in range(1, numLaps + 1):
            for j in range(1, min(max_laps_no_change, i) + 1):
                if i - j == 0:
                    current = min_time[j]
                else:
                    current = min_time[j] + changeTime + dp[i - j]
                if current < dp[i]:
                    dp[i] = current

        return dp[numLaps]