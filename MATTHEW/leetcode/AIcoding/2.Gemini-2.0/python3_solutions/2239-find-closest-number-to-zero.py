class Solution:
    def findClosestNumber(self, nums: list[int]) -> int:
        closest = nums[0]
        for num in nums:
            if abs(num) < abs(closest):
                closest = num
            elif abs(num) == abs(closest):
                closest = max(closest, num)
        return closest