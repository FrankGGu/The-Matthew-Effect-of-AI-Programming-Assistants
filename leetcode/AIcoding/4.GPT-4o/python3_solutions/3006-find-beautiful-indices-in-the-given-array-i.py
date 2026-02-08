class Solution:
    def beautifulIndices(self, nums: List[int]) -> List[int]:
        result = []
        total_sum = sum(nums)
        left_sum = 0

        for i in range(len(nums)):
            if left_sum + nums[i] == total_sum - left_sum - nums[i]:
                result.append(i)
            left_sum += nums[i]

        return result