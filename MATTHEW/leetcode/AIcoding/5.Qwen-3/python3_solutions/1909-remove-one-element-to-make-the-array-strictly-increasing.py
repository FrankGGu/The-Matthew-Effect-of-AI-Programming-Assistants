class Solution:
    def canBeIncreasing(self, nums: List[int]) -> bool:
        count = 0
        prev = nums[0]
        for i in range(1, len(nums)):
            if nums[i] <= prev:
                count += 1
                if i > 1 and nums[i] <= nums[i-2]:
                    return False
                prev = nums[i]
            else:
                prev = nums[i]
        return count <= 1