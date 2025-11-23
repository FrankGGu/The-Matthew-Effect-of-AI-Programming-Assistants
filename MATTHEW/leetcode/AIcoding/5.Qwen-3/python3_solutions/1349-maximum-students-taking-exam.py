class Solution:
    def maxStudents(self, seat: List[List[str]]) -> int:
        m, n = len(seat), len(seat[0])
        dp = [0] * (1 << n)
        for i in range(m):
            for j in range(1 << n):
                if (j & (j << 1)) == 0:
                    cnt = bin(j).count('1')
                    prev = j & ((1 << n) - 1)
                    for k in range(1 << n):
                        if (k & (k << 1)) == 0 and (k & prev) == k:
                            dp[j] = max(dp[j], dp[k] + cnt)
            for j in range(1 << n):
                if (j & (j << 1)) == 0:
                    if seat[i][0] == '#':
                        dp[j] = 0
                    else:
                        for k in range(1 << n):
                            if (k & (k << 1)) == 0 and (k & j) == k:
                                dp[j] = max(dp[j], dp[k])
        return max(dp)