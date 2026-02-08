class Solution:
    def maxStrength(self, nums: List[int]) -> int:
        nums = sorted(nums)
        product = 1
        negative_count = 0
        zero_count = 0

        for num in nums:
            if num < 0:
                negative_count += 1
            elif num == 0:
                zero_count += 1

        if negative_count % 2 == 1:
            negative_count -= 1

        for i in range(len(nums) - negative_count, len(nums)):
            product *= nums[i]

        if product == 0 and zero_count > 0:
            return 0

        return product