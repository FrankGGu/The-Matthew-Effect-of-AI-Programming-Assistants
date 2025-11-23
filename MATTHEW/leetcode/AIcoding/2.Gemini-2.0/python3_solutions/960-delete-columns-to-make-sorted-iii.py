class Solution:
    def minDeletionSize(self, strs: List[str]) -> int:
        n = len(strs)
        m = len(strs[0])
        dp = [1] * m
        for i in range(1, m):
            for j in range(i):
                flag = True
                for k in range(n):
                    if strs[k][j] > strs[k][i]:
                        flag = False
                        break
                if flag:
                    dp[i] = max(dp[i], dp[j] + 1)
        return m - max(dp)