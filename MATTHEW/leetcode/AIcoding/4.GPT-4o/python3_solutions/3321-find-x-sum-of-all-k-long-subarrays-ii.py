class Solution:
    def findXSum(self, nums: List[int], k: int) -> int:
        n = len(nums)
        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i + 1] = prefix_sum[i] + nums[i]

        total_sum = 0
        for i in range(n - k + 1):
            total_sum += prefix_sum[i + k] - prefix_sum[i]

        return total_sum