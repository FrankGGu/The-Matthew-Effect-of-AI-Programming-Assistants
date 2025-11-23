class Solution:
    def maximumTotalDamage(self, power: List[int]) -> int:
        from collections import Counter

        count = Counter(power)
        sorted_power = sorted(count.keys())
        n = len(sorted_power)
        dp = [0] * n

        for i in range(n):
            total = count[sorted_power[i]] * sorted_power[i]
            j = i - 1
            while j >= 0 and sorted_power[i] - sorted_power[j] > 1:
                j -= 1
            if j >= 0:
                total += dp[j]
            dp[i] = max(total, dp[i - 1] if i > 0 else 0)

        return dp[-1]