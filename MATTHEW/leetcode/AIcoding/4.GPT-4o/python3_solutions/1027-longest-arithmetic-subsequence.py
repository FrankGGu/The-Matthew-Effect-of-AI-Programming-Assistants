class Solution:
    def longestArithSeqLength(self, A: List[int]) -> int:
        if not A:
            return 0

        n = len(A)
        dp = [{} for _ in range(n)]
        max_length = 2

        for i in range(n):
            for j in range(i):
                diff = A[i] - A[j]
                if diff in dp[j]:
                    dp[i][diff] = dp[j][diff] + 1
                else:
                    dp[i][diff] = 2
                max_length = max(max_length, dp[i][diff])

        return max_length