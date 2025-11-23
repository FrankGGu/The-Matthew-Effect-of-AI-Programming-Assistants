class Solution:
    def maxSum(self, nums: List[int], k: int) -> int:
        n = len(nums)
        if n < k:
            return 0

        current_sum = sum(nums[:k])
        max_sum = current_sum

        for i in range(k, n):
            current_sum += nums[i] - nums[i - k]
            max_sum = max(max_sum, current_sum)

        return max_sum