class Solution:
    def maxNonDecreasingLength(self, A: List[int], B: List[int]) -> int:
        n = len(A)
        dp = [1] * n
        max_length = 1

        for i in range(1, n):
            if A[i] >= A[i - 1]:
                dp[i] = dp[i - 1] + 1
            if B[i] >= A[i - 1]:
                dp[i] = max(dp[i], dp[i - 1] + 1)
            if A[i] >= B[i - 1]:
                dp[i] = max(dp[i], (dp[i - 1] + 1) if i > 0 else 1)
            if B[i] >= B[i - 1]:
                dp[i] = max(dp[i], dp[i - 1] + 1)
            if B[i] >= A[i - 1]:
                dp[i] = max(dp[i], (dp[i - 1] + 1) if i > 0 else 1)

            max_length = max(max_length, dp[i])

        return max_length