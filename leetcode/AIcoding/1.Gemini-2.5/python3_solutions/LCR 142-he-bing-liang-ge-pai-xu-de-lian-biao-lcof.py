class Solution:
    def trainingPlan(self, n: int, m: int) -> int:
        MOD = 10**9 + 7

        # Base cases and special handling:
        # If n = 0, there are no days, so 0 plans. (Usually n >= 1 in problems)
        if n == 0:
            return 0
        # If m = 0, there are no training types, so 0 plans. (Usually m >= 1 in problems)
        if m == 0:
            return 0

        # The problem asks for the number of valid training plans of n days using m types,
        # where adjacent days must have different training types.

        # Let dp[i][j] be the number of valid plans for i days, with the i-th day having type j.
        # For i = 1: dp[1][j] = 1 for all j from 1 to m.
        # Total plans for 1 day = m.

        # For i > 1: dp[i][j] = sum(dp[i-1][k] for k != j).
        # Let S[i-1] be the total number of valid plans for i-1 days.
        # S[i-1] = sum(dp[i-1][k] for k in 1 to m).
        # Then dp[i][j] = S[i-1] - dp[i-1][j].

        # Observation: For any given day i, if m > 1, dp[i][j] will be the same for all j.
        # Let's denote this common value as val[i].
        # val[1] = 1.
        # S[1] = m * val[1] = m.

        # val[2] = S[1] - val[1] = m - 1.
        # S[2] = m * val[2] = m * (m - 1).

        # val[3] = S[2] - val[2] = m * (m - 1) - (m - 1) = (m - 1) * (m - 1).
        # S[3] = m * val[3] = m * (m - 1)^2.

        # Generalizing for i > 1 (and m > 1):
        # val[i] = (m - 1)^(i - 1).
        # S[i] = m * (m - 1)^(i - 1).

        # The final answer is S[n].
        # So, the formula is m * (m - 1)^(n - 1) % MOD.

        # This formula also correctly handles edge cases:
        # 1. If n = 1: result = m * (m - 1)^0 = m * 1 = m. (Correct, any of m types for 1 day).
        # 2. If m = 1:
        #    If n = 1: result = 1 * (1 - 1)^0 = 1 * 1 = 1. (Correct, only 1 type for 1 day).
        #    If n > 1: result = 1 * (1 - 1)^(n - 1) = 1 * 0^(n - 1).
        #              Since n - 1 > 0, 0^(n - 1) is 0. So result is 0.
        #              (Correct, if only 1 type, cannot have different adjacent types for >1 day).

        # Python's pow(base, exp, mod) handles pow(0, 0, mod) as 1 and pow(0, positive_exp, mod) as 0.
        # This makes the formula robust.

        result = (m * pow(m - 1, n - 1, MOD)) % MOD
        return result