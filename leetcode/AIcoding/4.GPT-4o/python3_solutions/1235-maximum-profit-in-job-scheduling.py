class Solution:
    def jobScheduling(self, startTime: List[int], endTime: List[int], profit: List[int]) -> int:
        jobs = sorted(zip(startTime, endTime, profit), key=lambda x: x[1])
        dp = [(0, 0)]  # (end time, profit)

        for s, e, p in jobs:
            i = bisect.bisect_right(dp, (s, float('inf'))) - 1
            if dp[i][1] + p > dp[-1][1]:
                dp.append((e, dp[i][1] + p))

        return dp[-1][1]