class Solution:
    def lenLongestFib subseq(self, arr):
        n = len(arr)
        dp = [{} for _ in range(n)]
        max_len = 0
        for i in range(n):
            for j in range(i):
                prev = arr[i] - arr[j]
                if prev in dp[j]:
                    dp[i][arr[j]] = dp[j][prev] + 1
                    max_len = max(max_len, dp[i][arr[j]])
                else:
                    dp[i][arr[j]] = 2
        return max_len