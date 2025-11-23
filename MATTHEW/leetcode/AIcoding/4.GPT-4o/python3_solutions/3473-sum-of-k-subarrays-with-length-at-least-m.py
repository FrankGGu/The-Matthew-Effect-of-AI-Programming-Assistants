class Solution:
    def maxSumOfSubarrays(self, nums: List[int], k: int, m: int) -> int:
        n = len(nums)
        if n < k:
            return 0

        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i + 1] = prefix_sum[i] + nums[i]

        max_sum = 0
        max_subarray_sum = float('-inf')

        for j in range(m, n + 1):
            max_subarray_sum = max(max_subarray_sum, prefix_sum[j - k])
            max_sum = max(max_sum, prefix_sum[j] - max_subarray_sum)

        return max_sum