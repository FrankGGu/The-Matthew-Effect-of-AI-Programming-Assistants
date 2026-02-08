import math

class Solution:
    def maxSumOfKSubarrays(self, nums: list[int], k: int, m: int) -> int:
        n = len(nums)

        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i+1] = prefix_sum[i] + nums[i]

        dp = [[float('-inf')] * (k + 1) for _ in range(n + 1)]

        dp[0][0] = 0

        for j in range(1, k + 1):
            max_prev_term = float('-inf')

            for i in range(1, n + 1):
                dp[i][j] = dp[i-1][j]

                if i >= m:
                    # Update max_prev_term with the value for the (j-1)-th subarray ending at index i-m-1.
                    # dp[i-m][j-1] is the max sum of j-1 subarrays using nums[0...i-m-1].
                    # prefix_sum[i-m] is the sum of nums[0...i-m-1].
                    if dp[i-m][j-1] != float('-inf'):
                        max_prev_term = max(max_prev_term, dp[i-m][j-1] - prefix_sum[i-m])

                # If a valid previous sum (max_prev_term) exists,
                # consider forming the j-th subarray ending at i-1.
                # The sum of this j-th subarray is prefix_sum[i] - prefix_sum[p], where p is its start.
                # max_prev_term already incorporates -prefix_sum[p] for the optimal p.
                if max_prev_term != float('-inf'):
                    dp[i][j] = max(dp[i][j], max_prev_term + prefix_sum[i])

        return dp[n][k]