class Solution:
    def numDistinct(self, s: str, t: str) -> int:
        m = len(s)
        n = len(t)

        # dp[j] will store the number of distinct subsequences of s[:i] that equal t[:j]
        # We use a 1D array for space optimization.
        # dp[0] is for empty string t, which can always be formed in 1 way.
        dp = [0] * (n + 1)
        dp[0] = 1

        # Iterate through each character of s
        for i in range(1, m + 1):
            # Iterate through t in reverse order to use values from the previous row (i-1)
            # without overwriting values needed for the current row (i) calculation.
            # j goes from n down to 1 because t[:0] (empty string) is handled by dp[0]=1.
            for j in range(n, 0, -1):
                if s[i - 1] == t[j - 1]:
                    # If characters match, we have two options:
                    # 1. Use s[i-1] to match t[j-1]: Add dp[j-1] (number of ways to form t[:j-1] from s[:i-1])
                    # 2. Don't use s[i-1]: Add dp[j] (number of ways to form t[:j] from s[:i-1])
                    dp[j] = dp[j] + dp[j - 1]
                else:
                    # If characters don't match, we must skip s[i-1].
                    # So, the number of ways to form t[:j] from s[:i] is
                    # the same as forming t[:j] from s[:i-1].
                    # dp[j] remains its previous value (from s[:i-1]).
                    pass

        return dp[n]