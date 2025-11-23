class Solution:
    def getSumAbsoluteDifferences(self, nums: List[int]) -> List[int]:
        n = len(nums)
        result = [0] * n
        total_sum = sum(nums)
        prefix_sum = 0
        for i in range(n):
            result[i] = nums[i] * i - prefix_sum + (total_sum - prefix_sum - nums[i] * (n - i))
            prefix_sum += nums[i]
        return result