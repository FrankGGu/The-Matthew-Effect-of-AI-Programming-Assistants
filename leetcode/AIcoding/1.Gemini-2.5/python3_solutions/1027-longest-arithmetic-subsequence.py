class Solution:
    def longestArithmeticSubsequence(self, nums: list[int]) -> int:
        n = len(nums)
        if n <= 2:
            return n

        dp = [{} for _ in range(n)]
        max_len = 1 

        for i in range(n):
            for j in range(i):
                diff = nums[i] - nums[j]

                # Length of arithmetic subsequence ending at j with this diff
                # If diff not found for dp[j], it means nums[j] is the first element
                # of such a subsequence, so its length is 1.
                prev_len = dp[j].get(diff, 1)

                # Current length ending at i is prev_len + 1
                current_len = prev_len + 1

                # Update dp[i] for this diff. Take max in case another j already
                # formed a longer subsequence ending at i with the same diff.
                dp[i][diff] = max(dp[i].get(diff, 1), current_len)

                max_len = max(max_len, dp[i][diff])

        return max_len