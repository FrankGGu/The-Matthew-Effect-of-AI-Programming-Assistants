class Solution:
    def selectKDisjointSpecialSubstrings(self, s: str, k: int) -> int:
        n = len(s)
        MOD = 10**9 + 7

        # dp[i][j] = number of ways to select j disjoint special substrings from s[0...i-1]
        # A special substring is defined as a substring where all characters are the same.
        dp = [[0] * (k + 1) for _ in range(n + 1)]

        # prefix_sum[j][i] = sum(dp[x][j] for x from 0 to i)
        # This helps in O(1) range sum queries for dp values.
        prefix_sum = [[0] * (n + 1) for _ in range(k + 1)]

        # Base case: 1 way to select 0 substrings (the empty set) from an empty prefix.
        dp[0][0] = 1

        # Base case: 1 way to select 0 substrings from any prefix of the string.
        for i in range(n + 1):
            dp[i][0] = 1

        # Initialize prefix_sum for k=0
        for i in range(n + 1):
            prefix_sum[0][i] = (prefix_sum[0][i-1] if i > 0 else 0) + dp[i][0]
            prefix_sum[0][i] %= MOD

        # Iterate through the string characters
        for i in range(1, n + 1):  # Current character being considered is s[i-1]
            # Iterate through the number of substrings to select
            for j in range(1, k + 1): 
                # Option 1: The character s[i-1] is NOT part of the j-th selected substring.
                # In this case, the number of ways is the same as selecting j substrings from s[0...i-2].
                dp[i][j] = dp[i-1][j]

                # Option 2: The character s[i-1] IS the end of the j-th special substring.
                # This special substring is s[p_curr...i-1], where all characters are s[i-1].
                # We need to find the earliest possible start index (`p_curr`) for such a substring.
                # `prev_char_idx` will be the index of the last character *different* from s[i-1] before s[i-1].
                # If all characters s[0...i-1] are the same as s[i-1], then `prev_char_idx` will be -1.
                prev_char_idx = i - 2
                while prev_char_idx >= 0 and s[prev_char_idx] == s[i-1]:
                    prev_char_idx -= 1

                # Any `p_curr` in the range `[prev_char_idx + 1, i-1]` can be the start of a special substring ending at `i-1`.
                # If we select `s[p_curr...i-1]` as the j-th substring, we need to add the number of ways
                # to select `j-1` disjoint special substrings from `s[0...p_curr-1]`. This is `dp[p_curr][j-1]`.
                # So, we need to sum `dp[x][j-1]` for `x` from `(prev_char_idx + 1)` to `(i-1)`.

                sum_range_start = prev_char_idx + 1
                sum_range_end = i - 1

                ways_from_prev_k_minus_1 = 0
                if sum_range_end >= sum_range_start:
                    # Calculate sum using prefix_sum array: prefix_sum[j-1][sum_range_end] - prefix_sum[j-1][sum_range_start - 1]
                    ways_from_prev_k_minus_1 = prefix_sum[j-1][sum_range_end]
                    if sum_range_start > 0:
                        ways_from_prev_k_minus_1 = (ways_from_prev_k_minus_1 - prefix_sum[j-1][sum_range_start - 1] + MOD) % MOD

                dp[i][j] = (dp[i][j] + ways_from_prev_k_minus_1) % MOD

            # After computing all dp[i][j] for the current `i`, update the prefix_sum for this `i`.
            for j in range(k + 1):
                prefix_sum[j][i] = (prefix_sum[j][i-1] + dp[i][j]) % MOD

        # The final answer is the number of ways to select k disjoint special substrings from the entire string s.
        return dp[n][k]