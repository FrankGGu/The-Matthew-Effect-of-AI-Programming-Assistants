class Solution:
    def checkRecord(self, n: int) -> int:
        MOD = 10**9 + 7

        # dp_prev[j][k] represents the number of rewardable records of length i-1
        # j: count of 'A's (0 or 1)
        # k: count of trailing 'L's (0, 1, or 2)
        dp_prev = [[0] * 3 for _ in range(2)]

        # Base case: empty string (length 0) has 0 'A's and 0 trailing 'L's
        dp_prev[0][0] = 1

        # Iterate for each length from 1 to n
        for _ in range(n):
            dp_curr = [[0] * 3 for _ in range(2)]

            for j in range(2):  # absent_count: 0 or 1
                for k in range(3):  # late_count: 0, 1, or 2
                    if dp_prev[j][k] == 0:
                        continue

                    # 1. Append 'P' (Present)
                    # 'P' resets trailing 'L' count to 0. 'A' count remains 'j'.
                    dp_curr[j][0] = (dp_curr[j][0] + dp_prev[j][k]) % MOD

                    # 2. Append 'L' (Late)
                    # Can only append 'L' if trailing 'L' count is less than 2.
                    # 'A' count remains 'j'. Trailing 'L' count becomes k+1.
                    if k < 2:
                        dp_curr[j][k + 1] = (dp_curr[j][k + 1] + dp_prev[j][k]) % MOD

                    # 3. Append 'A' (Absent)
                    # Can only append 'A' if 'A' count is 0.
                    # 'A' count becomes 1. Trailing 'L' count resets to 0.
                    if j == 0:
                        dp_curr[1][0] = (dp_curr[1][0] + dp_prev[j][k]) % MOD

            dp_prev = dp_curr

        # Sum all possible states for records of length n
        total_rewardable_records = 0
        for j in range(2):
            for k in range(3):
                total_rewardable_records = (total_rewardable_records + dp_prev[j][k]) % MOD

        return total_rewardable_records