class Solution:
    def countWays(self, s: str) -> int:
        MOD = 10**9 + 7
        n = len(s)
        prefix_sum = [0] * (n + 1)

        for i in range(n):
            prefix_sum[i + 1] = prefix_sum[i] + (s[i] == '1')

        total_ones = prefix_sum[n]
        if total_ones < 3:
            return 0

        count = 0
        ways = 0
        for i in range(n + 1):
            if prefix_sum[i] == 1:
                count += 1
            elif prefix_sum[i] == total_ones - 1:
                ways += count

        return ways % MOD