class Solution:
    def maxSumIntervals(self, intervals: List[List[int]]) -> int:
        intervals.sort(key=lambda x: x[1])
        dp = [0] * (len(intervals) + 1)

        for i in range(1, len(intervals) + 1):
            dp[i] = dp[i - 1]
            current_sum = intervals[i - 1][1] - intervals[i - 1][0] + 1

            for j in range(i - 1, -1, -1):
                if j == 0 or intervals[j - 1][1] < intervals[i - 1][0]:
                    dp[i] = max(dp[i], dp[j] + current_sum)
                    break

        return dp[len(intervals)]