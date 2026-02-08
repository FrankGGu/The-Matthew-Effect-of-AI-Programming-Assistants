class Solution:
    def optimalTemperature(self, temperature: list[int]) -> list[int]:
        n = len(temperature)
        ans = [0] * n
        for i in range(n):
            ans[i] = temperature[i]

        diffs = []
        for i in range(n - 1):
            diffs.append(temperature[i+1] - temperature[i])

        prefix_sum = [0] * (n)
        prefix_sum[0] = 0
        for i in range(n - 1):
            prefix_sum[i+1] = prefix_sum[i] + diffs[i]

        return ans