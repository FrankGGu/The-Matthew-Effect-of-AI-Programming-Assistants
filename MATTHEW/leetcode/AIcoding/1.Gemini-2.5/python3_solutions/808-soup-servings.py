import math

class Solution:
    def soupServings(self, N: int) -> float:
        # As N becomes large, the probability that soup A runs out first
        # (or at the same time as B) approaches 1.0.
        # This is because soup A is, on average, served more than soup B.
        # For N >= 4800, the probability is effectively 1.0 due to floating point precision.
        if N >= 4800:
            return 1.0

        # Convert N ml to units of 25 ml.
        # If N is not a multiple of 25, we need to round up.
        # For example, if N=1 ml, it counts as 1 unit of 25 ml for serving purposes.
        # This is equivalent to ceil(N / 25.0).
        n = (N + 24) // 25

        memo = {}

        def dp(a: int, b: int) -> float:
            # Check memoization table
            if (a, b) in memo:
                return memo[(a, b)]

            # Base cases
            if a <= 0 and b <= 0:
                # Both soups become empty simultaneously
                return 0.5
            if a <= 0:
                # Soup A becomes empty first
                return 1.0
            if b <= 0:
                # Soup B becomes empty first
                return 0.0

            # Recursive step: sum probabilities for the four operations
            # Each operation has a 0.25 probability
            # Operations in units of 25ml:
            # 1. Serve 4 units of A, 0 units of B
            # 2. Serve 3 units of A, 1 unit of B
            # 3. Serve 2 units of A, 2 units of B
            # 4. Serve 1 unit of A, 3 units of B

            prob = 0.25 * (
                dp(max(0, a - 4), b) +
                dp(max(0, a - 3), max(0, b - 1)) +
                dp(max(0, a - 2), max(0, b - 2)) +
                dp(max(0, a - 1), max(0, b - 3))
            )

            # Store result in memoization table
            memo[(a, b)] = prob
            return prob

        # Start DP with initial amounts (n, n)
        return dp(n, n)