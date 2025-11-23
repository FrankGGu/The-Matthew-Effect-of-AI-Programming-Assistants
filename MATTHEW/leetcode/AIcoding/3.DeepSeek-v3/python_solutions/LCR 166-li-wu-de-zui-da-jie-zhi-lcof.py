class Solution:
    def jewelleryValue(self, frame: List[List[int]]) -> int:
        if not frame or not frame[0]:
            return 0
        m, n = len(frame), len(frame[0])
        dp = [[0] * n for _ in range(m)]
        dp[0][0] = frame[0][0]
        for i in range(1, m):
            dp[i][0] = dp[i-1][0] + frame[i][0]
        for j in range(1, n):
            dp[0][j] = dp[0][j-1] + frame[0][j]
        for i in range(1, m):
            for j in range(1, n):
                dp[i][j] = max(dp[i-1][j], dp[i][j-1]) + frame[i][j]
        return dp[-1][-1]