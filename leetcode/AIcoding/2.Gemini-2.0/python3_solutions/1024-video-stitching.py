class Solution:
    def videoStitching(self, clips: List[List[int]], time: int) -> int:
        clips.sort()
        dp = [float('inf')] * (time + 1)
        dp[0] = 0
        for i in range(1, time + 1):
            for clip in clips:
                if clip[0] <= i - 1 <= clip[1]:
                    dp[i] = min(dp[i], dp[clip[0]] + 1)
        return dp[time] if dp[time] != float('inf') else -1