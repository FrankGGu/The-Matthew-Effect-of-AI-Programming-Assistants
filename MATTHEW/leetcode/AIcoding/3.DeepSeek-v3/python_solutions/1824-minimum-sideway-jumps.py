class Solution:
    def minSideJumps(self, obstacles: List[int]) -> int:
        n = len(obstacles)
        dp = [[float('inf')] * 3 for _ in range(n)]
        dp[0][0] = 1
        dp[0][1] = 0
        dp[0][2] = 1

        for i in range(1, n):
            for lane in range(3):
                if obstacles[i] == lane + 1:
                    continue
                min_jumps = float('inf')
                for prev_lane in range(3):
                    if obstacles[i-1] == prev_lane + 1:
                        continue
                    if prev_lane == lane:
                        min_jumps = min(min_jumps, dp[i-1][prev_lane])
                    else:
                        min_jumps = min(min_jumps, dp[i-1][prev_lane] + 1)
                dp[i][lane] = min_jumps

        return min(dp[-1])