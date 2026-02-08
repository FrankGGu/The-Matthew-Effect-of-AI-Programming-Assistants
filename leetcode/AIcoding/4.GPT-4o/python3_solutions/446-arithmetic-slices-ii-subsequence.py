class Solution:
    def numberOfArithmeticSlices(self, A: List[int]) -> int:
        from collections import defaultdict
        n = len(A)
        dp = [defaultdict(int) for _ in range(n)]
        total_slices = 0

        for i in range(n):
            for j in range(i):
                diff = A[i] - A[j]
                count = dp[j][diff]
                dp[i][diff] += count + 1
                total_slices += count

        return total_slices