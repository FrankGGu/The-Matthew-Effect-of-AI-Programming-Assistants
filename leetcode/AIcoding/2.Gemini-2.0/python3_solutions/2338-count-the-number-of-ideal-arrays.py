class Solution:
    def idealArrays(self, n: int, maxValue: int) -> int:
        MOD = 10**9 + 7
        dp = [[0] * (maxValue + 1) for _ in range(n + 1)]
        C = [[0] * (n + 1) for _ in range(n + 1)]
        for i in range(n + 1):
            C[i][0] = 1
            C[i][i] = 1
            for j in range(1, i):
                C[i][j] = (C[i-1][j-1] + C[i-1][j]) % MOD

        for i in range(1, maxValue + 1):
            dp[1][i] = 1

        for i in range(2, n + 1):
            for j in range(1, maxValue + 1):
                for k in range(j * 2, maxValue + 1, j):
                    dp[i][j] = (dp[i][j] + dp[i - 1][k]) % MOD

        ans = 0
        for i in range(1, maxValue + 1):
            count = 0
            curr = i
            while curr <= maxValue:
                count += 1
                curr *= 2
            ans = (ans + dp[n][i]) % MOD

        count = 0
        for i in range(1, maxValue + 1):
            if dp[n][i] > 0:
                count +=1

        ans = 0
        for i in range(1, maxValue + 1):
          cnt = 0
          val = i
          while val <= maxValue:
            cnt += 1
            val *= 2

          ans = (ans + C[n-1][cnt-1]) % MOD

        return ans