from collections import defaultdict

class Solution:
    def longestSubsequence(self, arr: list[int]) -> int:
        n = len(arr)
        if n <= 1:
            return n

        # dp[i] is a dictionary where keys are 'last_difference'
        # and values are the length of the longest subsequence ending at arr[i]
        # with that specific 'last_difference'.
        dp = [defaultdict(int) for _ in range(n)]

        # The minimum possible length of a subsequence is 1 (any single element).
        max_overall_len = 1

        # Iterate through each element arr[i] as the potential end of a subsequence.
        for i in range(n):
            # For each arr[i], consider all previous elements arr[j] (where j < i)
            # as the element immediately preceding arr[i] in the subsequence.
            for j in range(i):
                current_diff = arr[i] - arr[j]

                # We need to find the maximum length of a subsequence ending at arr[j]
                # such that its last difference (prev_diff) is strictly greater than current_diff.
                max_len_from_j = 0
                for prev_diff, length in dp[j].items():
                    if prev_diff > current_diff:
                        max_len_from_j = max(max_len_from_j, length)

                # Calculate the new length for the subsequence ending at arr[i] with current_diff.
                # If max_len_from_j is 0, it means no valid previous element k (before j) was found
                # to extend a subsequence. In this case, the subsequence is just (arr[j], arr[i]),
                # so its length is 2.
                if max_len_from_j == 0:
                    new_len = 2
                else:
                    new_len = 1 + max_len_from_j

                # Update dp[i] for the current_diff.
                # We take the maximum length if multiple subsequences ending at arr[i]
                # have the same current_diff but originate from different valid paths.
                dp[i][current_diff] = max(dp[i].get(current_diff, 0), new_len)

                # Update the overall maximum length found so far across all subsequences.
                max_overall_len = max(max_overall_len, dp[i][current_diff])

        return max_overall_len