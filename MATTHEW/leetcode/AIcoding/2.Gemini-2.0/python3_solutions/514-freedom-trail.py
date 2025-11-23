class Solution:
    def findRotateSteps(self, ring: str, key: str) -> int:
        n = len(ring)
        m = len(key)
        pos = [[] for _ in range(26)]
        for i, c in enumerate(ring):
            pos[ord(c) - ord('a')].append(i)
        dp = [[float('inf')] * n for _ in range(m + 1)]
        dp[0][0] = 0
        for i in range(m):
            for j in range(n):
                if dp[i][j] != float('inf'):
                    for k in pos[ord(key[i]) - ord('a')]:
                        diff = abs(j - k)
                        step = min(diff, n - diff)
                        dp[i + 1][k] = min(dp[i + 1][k], dp[i][j] + step + 1)
        return min(dp[m])