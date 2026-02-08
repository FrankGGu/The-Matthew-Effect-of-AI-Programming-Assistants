class Solution:
    def rearrangeSticks(self, n: int, k: int) -> int:
        MOD = 10**9 + 7

        dp = [[0] * (k + 1) for _ in range(n + 1)]

        dp[0][0] = 1 

        for i in range(1, n + 1):
            for j in range(1, k + 1):
                # Case 1: Place the tallest stick (length i) at the very left.
                # It is visible. We need to arrange the remaining i-1 sticks
                # such that j-1 of them are visible.
                term1 = dp[i-1][j-1]

                # Case 2: Place the tallest stick (length i) somewhere else.
                # It must be placed to the right of one of the i-1 shorter sticks.
                # In this case, the tallest stick 'i' will be hidden by the stick
                # immediately to its left (which must be shorter than 'i').
                # There are (i-1) such positions where stick 'i' can be placed
                # among the other i-1 sticks, effectively hiding it.
                # The number of visible sticks remains 'j' from the arrangement
                # of the i-1 shorter sticks.
                term2 = (dp[i-1][j] * (i - 1)) % MOD

                dp[i][j] = (term1 + term2) % MOD

        return dp[n][k]