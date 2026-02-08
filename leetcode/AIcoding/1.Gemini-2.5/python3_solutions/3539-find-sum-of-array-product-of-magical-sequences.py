class Solution:
    def solve(self, n: int, k: int) -> int:
        MOD = 10**9 + 7

        dp = [0] * (k + 1)

        for j in range(1, k + 1):
            dp[j] = j

        for _ in range(2, n + 1):
            new_dp = [0] * (k + 1)

            sum_divisors = [0] * (k + 1)
            for d in range(1, k + 1):
                if dp[d] == 0:
                    continue
                for x in range(d, k + 1, d):
                    sum_divisors[x] = (sum_divisors[x] + dp[d]) % MOD

            sum_multiples = [0] * (k + 1)
            for m in range(1, k + 1):
                if dp[m] == 0:
                    continue
                for x in range(1, int(m**0.5) + 1):
                    if m % x == 0:
                        sum_multiples[x] = (sum_multiples[x] + dp[m]) % MOD
                        if x * x != m:
                            sum_multiples[m // x] = (sum_multiples[m // x] + dp[m]) % MOD

            for j in range(1, k + 1):
                sum_prev_contributions = (sum_divisors[j] + sum_multiples[j] - dp[j] + MOD) % MOD
                new_dp[j] = (j * sum_prev_contributions) % MOD

            dp = new_dp

        total_sum_of_products = 0
        for j in range(1, k + 1):
            total_sum_of_products = (total_sum_of_products + dp[j]) % MOD

        return total_sum_of_products