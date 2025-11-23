class Solution:
    def waysToReachTarget(self, target: int, questions: list[list[int]]) -> int:
        MOD = 10**9 + 7

        dp = [0] * (target + 1)
        dp[0] = 1

        for points_i, count_i in questions:
            for j in range(target, -1, -1):
                if dp[j] == 0:
                    continue

                for k in range(1, count_i + 1):
                    current_points = j + k * points_i

                    if current_points > target:
                        break

                    dp[current_points] = (dp[current_points] + dp[j]) % MOD

        return dp[target]