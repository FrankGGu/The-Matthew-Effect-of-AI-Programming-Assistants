class Solution:
    def minDeletionSize(self, strs: list[str]) -> int:
        num_rows = len(strs)
        num_cols = len(strs[0])

        # dp[j] will store the maximum length of a lexicographically sorted subsequence of columns
        # ending at column j.
        dp = [1] * num_cols

        for j in range(num_cols):
            for i in range(j):
                # Check if column i can precede column j
                can_precede = True
                for r in range(num_rows):
                    if strs[r][i] > strs[r][j]:
                        can_precede = False
                        break

                if can_precede:
                    dp[j] = max(dp[j], 1 + dp[i])

        # The maximum length of a sorted subsequence of columns we can keep
        max_kept_cols = 0
        if num_cols > 0:
            max_kept_cols = max(dp)
        else: # Handle case where there are no columns (empty strings or empty list of strings)
            return 0

        # The minimum number of columns to delete is total columns - maximum columns kept
        return num_cols - max_kept_cols