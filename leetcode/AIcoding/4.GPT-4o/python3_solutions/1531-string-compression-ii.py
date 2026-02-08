class Solution:
    def getLengthOfOptimalCompression(self, s: str, k: int) -> int:
        n = len(s)
        dp = [[[float('inf')] * (k + 1) for _ in range(2)] for _ in range(n + 1)]
        dp[0][0][0] = 0

        for i in range(1, n + 1):
            count = [0] * 128
            for j in range(i, 0, -1):
                count[ord(s[j - 1])] += 1
                for rem in range(k + 1):
                    for take in range(1, count[ord(s[j - 1])] + 1):
                        if rem >= take - 1:
                            dp[i][1][rem] = min(dp[i][1][rem], dp[j - 1][0][rem - (take - 1)] + self.compressLength(take))
            for rem in range(k + 1):
                dp[i][0][rem] = min(dp[i][0][rem], dp[i - 1][0][rem])
                if rem > 0:
                    dp[i][0][rem] = min(dp[i][0][rem], dp[i - 1][1][rem - 1])

        return min(dp[n][0][k], dp[n][1][k])

    def compressLength(self, count: int) -> int:
        if count == 1:
            return 1
        if count < 10:
            return 2
        if count < 100:
            return 3
        return 4