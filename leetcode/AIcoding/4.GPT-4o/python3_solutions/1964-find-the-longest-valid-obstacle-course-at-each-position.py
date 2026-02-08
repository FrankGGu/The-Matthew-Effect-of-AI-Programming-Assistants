class Solution:
    def longestObstacleCourseAtEachPosition(self, obstacles: List[int]) -> List[int]:
        from bisect import bisect_right

        dp = []
        result = []

        for obstacle in obstacles:
            pos = bisect_right(dp, obstacle)
            if pos < len(dp):
                dp[pos] = obstacle
            else:
                dp.append(obstacle)
            result.append(pos + 1)

        return result