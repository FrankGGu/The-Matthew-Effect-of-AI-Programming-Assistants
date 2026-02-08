class Solution:
    def minChanges(self, nums: List[int], k: int) -> int:
        n = len(nums)
        count = [{} for _ in range(k)]

        for i in range(n):
            count[i % k][nums[i]] = count[i % k].get(nums[i], 0) + 1

        dp = [[0] * 102 for _ in range(k + 1)]

        for j in range(k):
            total = sum(count[j].values())
            for x in range(102):
                dp[j + 1][x] = total - count[j].get(x, 0)

        for j in range(k):
            for x in range(102):
                for y, freq in count[j].items():
                    dp[j + 1][y] = min(dp[j + 1][y], dp[j][x] + total - freq)

        return min(dp[k])