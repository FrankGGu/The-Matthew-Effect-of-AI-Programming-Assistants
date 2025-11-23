class Solution:
    def numDistinct(self, s: str, t: str) -> int:
        m = len(s)
        n = len(t)

        # dp[j] will store the number of distinct subsequences of s[:i] that equal t[:j]
        # We use a 1D array for space optimization.
        # dp[j] represents dp[i-1][j] when we are calculating dp[i][j].
        # When iterating j backwards, dp[j-1] will represent dp[i-1][j-1].
        dp = [0] * (n + 1)

        # Base case: An empty string t (t[:0]) can always be formed in one way (by choosing an empty subsequence).
        dp[0] = 1

        # Iterate through string s
        for i in range(1, m + 1):
            # Iterate through string t backwards to use values from the previous row (i-1)
            # dp[j] (current) depends on dp[j] (previous row) and dp[j-1] (previous row)
            # Iterating backwards ensures that dp[j-1] still holds the value from the (i-1)-th row
            # when we calculate dp[j] for the i-th row.
            for j in range(n, 0, -1):
                if s[i - 1] == t[j - 1]:
                    # If characters match, we have two options:
                    # 1. Match s[i-1] with t[j-1]: Add ways to form t[:j-1] from s[:i-1] (dp[j-1])
                    # 2. Don't match s[i-1] with t[j-1] (discard s[i-1]): Add ways to form t[:j] from s[:i-1] (dp[j])
                    dp[j] = dp[j - 1] + dp[j]
                else:
                    # If characters don't match, s[i-1] cannot be used to form t[j-1].
                    # So, we must discard s[i-1] and find ways to form t[:j] from s[:i-1].
                    # This means dp[j] remains its value from the previous row (dp[j]).
                    pass # dp[j] already holds the value from dp[i-1][j]

        return dp[n]