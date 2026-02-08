class Solution:
    def peopleAwareOfSecret(self, n: int, delay: int, forget: int) -> int:
        MOD = 10**9 + 7

        # dp[i] stores the number of people who learn the secret on day i.
        dp = [0] * (n + 1)

        # On day 1, one person learns the secret.
        dp[1] = 1

        # `can_spread_count` is the number of people who are currently able to spread the secret.
        # A person who learned on day k can spread on day i if:
        # 1. They are old enough to spread: k + delay <= i
        # 2. They have not forgotten yet: k + forget > i
        # So, k is in the range [i - forget + 1, i - delay].
        # This variable maintains the sum of dp[k] for k in this window.
        can_spread_count = 0

        # `total_aware_count` is the total number of people currently aware of the secret.
        # A person who learned on day k is aware on day i if k + forget > i.
        # This variable maintains the sum of dp[k] for k such that k + forget > i.
        total_aware_count = 0

        for i in range(1, n + 1):
            # Update `can_spread_count` for the current day `i`.
            # People who learned on day `i - delay` start spreading on day `i`.
            if i - delay >= 1:
                can_spread_count = (can_spread_count + dp[i - delay]) % MOD

            # People who learned on day `i - forget` forget the secret on day `i`.
            # So they stop spreading on day `i`.
            if i - forget >= 1:
                can_spread_count = (can_spread_count - dp[i - forget] + MOD) % MOD

            # Update `dp[i]` (number of new people learning on day `i`).
            # For day 1, it's 1 (initial condition). For i > 1, it's `can_spread_count`.
            if i > 1:
                dp[i] = can_spread_count

            # Update `total_aware_count` for the current day `i`.
            # Add people who learned on day `i`.
            total_aware_count = (total_aware_count + dp[i]) % MOD

            # People who learned on day `i - forget` forget the secret on day `i`.
            # So they are no longer aware on day `i`. Remove them from `total_aware_count`.
            if i - forget >= 1:
                total_aware_count = (total_aware_count - dp[i - forget] + MOD) % MOD

        return total_aware_count