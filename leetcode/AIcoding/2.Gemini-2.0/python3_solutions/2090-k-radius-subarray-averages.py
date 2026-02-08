class Solution:
    def getAverages(self, nums: List[int], k: int) -> List[int]:
        n = len(nums)
        averages = [-1] * n
        if 2 * k + 1 > n:
            return averages

        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i + 1] = prefix_sum[i] + nums[i]

        for i in range(k, n - k):
            window_sum = prefix_sum[i + k + 1] - prefix_sum[i - k]
            averages[i] = window_sum // (2 * k + 1)

        return averages