class Solution:
    def findTheArrayConcVal(self, nums: List[int]) -> int:
        left = 0
        right = len(nums) - 1
        res = 0
        while left <= right:
            if left == right:
                res += nums[left]
            else:
                res += int(str(nums[left]) + str(nums[right]))
            left += 1
            right -= 1
        return res