class Solution:
    def minPairSum(self, nums: List[int]) -> int:
        nums.sort()
        max_sum = 0
        for i in range(len(nums) // 2):
            max_sum = max(max_sum, nums[i] + nums[len(nums) - i - 1])
        return max_sum