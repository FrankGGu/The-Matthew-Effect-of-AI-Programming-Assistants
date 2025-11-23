class Solution:
    def numberOfWays(self, s: str) -> int:
        n = len(s)
        MOD = 10**9 + 7

        # lcp[i][j] stores the length of the longest common prefix of s[i:] and s[j:]
        lcp = [[0] * (n + 1) for _ in range(n + 1)]
        for i in range(n - 1, -1, -1):
            for j in range(n - 1, -1, -1):
                if s[i] == s[j]:
                    lcp[i][j] = 1 + lcp[i + 1][j + 1]

        # dp[i][j] stores the number of ways to separate s[0...i-1]
        # such that the last number s[i-j...i-1] has length j.
        dp = [[0] * (n + 1) for _ in range(n + 1)]

        # prefix_sum_dp[i][j] stores the sum of dp[i][k] for 1 <= k <= j.
        # This helps in O(1) lookup for sums over previous lengths.
        prefix_sum_dp = [[0] * (n + 1) for _ in range(n + 1)]

        for i in range(1, n + 1):  # i is the exclusive end index of the prefix s[0...i-1]
            for j in range(1, i + 1):  # j is the length of the current number s[i-j...i-1]
                curr_num_start_idx = i - j
                curr_num_len = j

                if s[curr_num_start_idx] == '0':
                    # Current number starts with '0', so it's invalid.
                    # No ways to form this number.
                    # Since we iterate `j` from `1` to `i`, if `s[curr_num_start_idx]` is '0',
                    # any subsequent `j'` (meaning `curr_num_start_idx'` would be smaller) would also be invalid for that `j'`.
                    # So we can break from this inner loop.
                    break

                if curr_num_start_idx == 0:
                    # This is the first number in the separation.
                    # There's 1 way to form this number (s[0...i-1]).
                    dp[i][j] = 1
                else:
                    # This is not the first number. We need to compare it with the previous number.
                    prev_end_idx = curr_num_start_idx

                    # Case 1: Previous number (s[prev_num_start_idx...prev_end_idx-1]) has length `prev_len` < `curr_num_len`.
                    # In this case, `prev_num` is always considered smaller than `curr_num` because `curr_num` is longer.
                    # We sum up all ways for `prev_len` from 1 up to `min(prev_end_idx, curr_num_len - 1)`.
                    ways_from_shorter_prev = prefix_sum_dp[prev_end_idx][min(prev_end_idx, curr_num_len - 1)]
                    dp[i][j] = (dp[i][j] + ways_from_shorter_prev) % MOD

                    # Case 2: Previous number has length `prev_len` == `curr_num_len`.
                    # We need to compare them lexicographically.
                    if curr_num_len <= prev_end_idx:  # Ensure prev_num_start_idx is valid (>=0)
                        prev_num_start_idx = prev_end_idx - curr_num_len

                        # Check if s[prev_num_start_idx...prev_end_idx-1] <= s[curr_num_start_idx...i-1]
                        l = lcp[prev_num_start_idx][curr_num_start_idx]

                        is_prev_smaller_or_equal_to_curr = False
                        if l >= curr_num_len:
                            # Previous number and current number are identical.
                            is_prev_smaller_or_equal_to_curr = True
                        elif s[prev_num_start_idx + l] < s[curr_num_start_idx + l]:
                            # Previous number is lexicographically smaller.
                            is_prev_smaller_or_equal_to_curr = True

                        if is_prev_smaller_or_equal_to_curr:
                            dp[i][j] = (dp[i][j] + dp[prev_end_idx][curr_num_len]) % MOD

                # Update prefix_sum_dp for current `i` and `j`.
                prefix_sum_dp[i][j] = (prefix_sum_dp[i][j-1] + dp[i][j]) % MOD

        return prefix_sum_dp[n][n]