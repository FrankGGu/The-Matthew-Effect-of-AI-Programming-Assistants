class Solution:
    def maxOperations(self, nums: List[int]) -> int:
        count = 0
        left, right = 0, len(nums) - 1
        while left < right:
            if nums[left] == 1:
                left += 1
            elif nums[right] == 0:
                right -= 1
            else:
                nums[left], nums[right] = nums[right], nums[left]
                count += 1
                left += 1
                right -= 1
        return count