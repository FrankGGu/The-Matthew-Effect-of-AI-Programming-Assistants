class Solution:
    def mindGame(self, nums: list[int], k: int) -> int:
        MOD = 10**9 + 7

        dp = [0] * 10

        for num in nums:
            digit = num % 10

            temp_dp = [0] * 10

            for prev_digit in range(10):
                if dp[prev_digit] > 0:
                    current_digit = (prev_digit + digit) % 10
                    temp_dp[current_digit] = (temp_dp[current_digit] + dp[prev_digit]) % MOD

            for i in range(10):
                dp[i] = (dp[i] + temp_dp[i]) % MOD

            dp[digit] = (dp[digit] + 1) % MOD

        return dp[k]