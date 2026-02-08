class Solution:
    def countSubMultisets(self, nums: List[int], l: int, r: int) -> int:
        MOD = 10**9 + 7
        from collections import Counter
        cnt = Counter(nums)
        keys = sorted(cnt.keys())
        max_sum = r
        dp = [0] * (max_sum + 1)
        dp[0] = 1
        for num in keys:
            freq = cnt[num]
            new_dp = dp.copy()
            for s in range(num, max_sum + 1):
                new_dp[s] = (new_dp[s] + new_dp[s - num]) % MOD
                if s >= (freq + 1) * num:
                    new_dp[s] = (new_dp[s] - dp[s - (freq + 1) * num]) % MOD
            dp = new_dp
        total = 0
        for s in range(l, r + 1):
            total = (total + dp[s]) % MOD
        return total