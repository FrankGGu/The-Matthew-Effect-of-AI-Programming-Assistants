class Solution:
    def longestArithSeqLength(self, arr: List[int], difference: int) -> int:
        dp = {}
        max_len = 1
        for i in range(len(arr)):
            dp[i] = {}
            for j in range(i):
                if arr[i] - arr[j] == difference:
                    if j in dp and difference in dp[j]:
                        dp[i][difference] = dp[j][difference] + 1
                    else:
                        dp[i][difference] = 2
                    max_len = max(max_len, dp[i][difference])

            if difference not in dp[i]:
                dp[i][difference] = 1

        return max_len