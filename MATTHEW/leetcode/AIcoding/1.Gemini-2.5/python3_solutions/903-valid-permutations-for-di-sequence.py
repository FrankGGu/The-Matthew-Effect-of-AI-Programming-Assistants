class Solution:
    def numPermsDISequence(self, s: str) -> int:
        n = len(s)
        MOD = 10**9 + 7

        # dp[j] will store the number of valid permutations of [0, ..., k]
        # such that the (k+1)-th element (perm[k]) has rank j among [0, ..., k].
        # Initialize dp for k=0 (permutation [0]).
        # dp[0] = 1 (for perm[0] having rank 0)
        dp = [1] 

        for k in range(n):
            # We are extending from permutations of [0, ..., k] to [0, ..., k+1]
            # using the character s[k] which relates perm[k] and perm[k+1].

            dp_prev = dp # dp_prev corresponds to dp[k]
            dp_curr = [0] * (k + 2) # dp_curr corresponds to dp[k+1], ranks from 0 to k+1

            if s[k] == 'I': # perm[k] < perm[k+1]
                # dp_curr[j] = sum(dp_prev[prev_j] for prev_j in range(j))
                # This means dp_curr[j] = dp_prev[0] + ... + dp_prev[j-1]
                # This can be computed as dp_curr[j] = dp_curr[j-1] + dp_prev[j-1]
                # for j > 0, with dp_curr[0] = 0.

                # dp_curr[0] is already 0.
                for j in range(1, k + 2): # j is the rank of perm[k+1] among [0, ..., k+1]
                    dp_curr[j] = (dp_curr[j-1] + dp_prev[j-1]) % MOD

            else: # s[k] == 'D', perm[k] > perm[k+1]
                # dp_curr[j] = sum(dp_prev[prev_j] for prev_j in range(j, k + 1))
                # This means dp_curr[j] = dp_prev[j] + ... + dp_prev[k]
                # This can be computed as dp_curr[j] = dp_prev[j] + dp_curr[j+1]
                # for j <= k, with dp_curr[k+1] = 0.

                # dp_curr[k+1] is already 0.
                for j in range(k, -1, -1): # j is the rank of perm[k+1] among [0, ..., k+1]
                    dp_curr[j] = (dp_prev[j] + dp_curr[j+1]) % MOD

            dp = dp_curr

        # The final answer is the sum of all elements in dp[n]
        return sum(dp) % MOD