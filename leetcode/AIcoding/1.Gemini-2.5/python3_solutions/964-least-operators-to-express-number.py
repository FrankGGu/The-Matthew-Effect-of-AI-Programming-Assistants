import functools

class Solution:
    def leastOpsExpressTarget(self, x: int, target: int) -> int:

        @functools.lru_cache(None)
        def solve(t):
            if t == 0:
                return 0
            if t == 1:
                return 3 # Cost for x/x
            if t == x:
                return 1 # Cost for x

            # Find k such that x^k <= t < x^(k+1)
            k = 0
            power_x = 1
            while power_x * x <= t:
                power_x *= x
                k += 1

            # power_x is x^k
            # power_x_next is x^(k+1)
            power_x_next = power_x * x

            # Cost to form x^k
            # If k=0 (x^0=1), cost is 3 (x/x). Otherwise, cost is k.
            cost_k = k if k > 0 else 3

            # Cost to form x^(k+1)
            # If k+1=0 (x^0=1), cost is 3. Otherwise, cost is k+1.
            cost_k_plus_1 = (k + 1) if (k + 1) > 0 else 3

            # Option 1: Express t as x^k + remainder
            # Cost to make x^k is cost_k.
            # If remainder is 0 (i.e., t == x^k), no '+' operator is needed.
            # If remainder > 0, one '+' operator is needed, plus the cost to solve for the remainder.
            ans1 = cost_k + (1 if t - power_x > 0 else 0) + solve(t - power_x)

            # Option 2: Express t as x^(k+1) - remainder
            # Cost to make x^(k+1) is cost_k_plus_1.
            # One '-' operator is needed, plus the cost to solve for the remainder (x^(k+1) - t).
            # Since k is chosen such that t < x^(k+1), the remainder (power_x_next - t) will always be > 0.
            ans2 = cost_k_plus_1 + 1 + solve(power_x_next - t)

            return min(ans1, ans2)

        return solve(target)