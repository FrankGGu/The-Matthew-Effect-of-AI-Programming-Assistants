class Solution:
    def distinctSequences(self, n: int) -> int:
        MOD = 10**9 + 7
        from collections import defaultdict

        dp = defaultdict(int)
        for a in range(1, 7):
            dp[(a,)] = 1

        for _ in range(n - 1):
            new_dp = defaultdict(int)
            for seq in dp:
                last = seq[-1]
                for next_num in range(1, 7):
                    if next_num != last and abs(next_num - last) > 1:
                        new_seq = seq + (next_num,)
                        new_dp[new_seq] = (new_dp[new_seq] + dp[seq]) % MOD
            dp = new_dp

        return sum(dp.values()) % MOD