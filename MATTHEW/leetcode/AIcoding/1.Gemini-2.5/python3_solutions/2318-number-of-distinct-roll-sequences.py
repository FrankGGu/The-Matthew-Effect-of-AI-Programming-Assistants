import math

class Solution:
    def distinctSequences(self, n: int) -> int:
        MOD = 10**9 + 7

        prev_dp = [0] * 7
        for i in range(1, 7):
            prev_dp[i] = 1

        if n == 1:
            return sum(prev_dp) % MOD

        for _ in range(n - 1):
            curr_dp = [0] * 7
            for current_roll in range(1, 7):
                for prev_roll in range(1, 7):
                    if prev_roll != current_roll and math.gcd(prev_roll, current_roll) == 1:
                        curr_dp[current_roll] = (curr_dp[current_roll] + prev_dp[prev_roll]) % MOD
            prev_dp = curr_dp

        return sum(prev_dp) % MOD