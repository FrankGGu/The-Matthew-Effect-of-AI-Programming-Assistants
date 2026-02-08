class Solution:
    def kthSmallestPath(self, destination: List[int], k: int) -> str:
        v, h = destination
        dp = [[0] * (h + 1) for _ in range(v + 1)]
        dp[0][0] = 1
        for i in range(v + 1):
            for j in range(h + 1):
                if i > 0:
                    dp[i][j] += dp[i - 1][j]
                if j > 0:
                    dp[i][j] += dp[i][j - 1]
        ans = ""
        for _ in range(v + h):
            if h > 0:
                if k <= dp[v][h - 1]:
                    ans += "H"
                    h -= 1
                else:
                    ans += "V"
                    k -= dp[v][h - 1]
                    v -= 1
            else:
                ans += "V"
                v -= 1
        return ans