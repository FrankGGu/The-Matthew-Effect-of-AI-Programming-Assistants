class Solution:
    def maxSubarraySum(self, nums: List[int], k: int) -> int:
        n = len(nums)
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i + 1] = prefix[i] + nums[i]
        max_sum = float('-inf')
        for i in range(k, n + 1):
            for j in range(i - k, i):
                if (i - j) % k == 0:
                    max_sum = max(max_sum, prefix[i] - prefix[j])
        return max_sum