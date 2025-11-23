class Solution:
    def largestGoodInteger(self, nums: str) -> int:
        max_num = -1
        for i in range(len(nums) - 2):
            if nums[i] == nums[i+1] == nums[i+2]:
                current = int(nums[i:i+3])
                if current > max_num:
                    max_num = current
        return max_num