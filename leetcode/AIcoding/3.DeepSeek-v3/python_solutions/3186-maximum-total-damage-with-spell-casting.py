class Solution:
    def maximumTotalDamage(self, power: List[int]) -> int:
        from collections import defaultdict

        freq = defaultdict(int)
        for num in power:
            freq[num] += 1

        unique_powers = sorted(freq.keys())
        n = len(unique_powers)
        dp = [0] * (n + 1)

        for i in range(n - 1, -1, -1):
            current_power = unique_powers[i]
            total = current_power * freq[current_power]

            next_non_conflict = i + 1
            while next_non_conflict < n and unique_powers[next_non_conflict] <= current_power + 2:
                next_non_conflict += 1

            if next_non_conflict < n:
                total += dp[next_non_conflict]

            dp[i] = max(total, dp[i + 1] if i + 1 < n else 0)

        return dp[0]