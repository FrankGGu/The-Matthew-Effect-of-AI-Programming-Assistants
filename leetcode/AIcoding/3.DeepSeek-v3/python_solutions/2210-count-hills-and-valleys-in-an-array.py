class Solution:
    def countHillValley(self, nums: List[int]) -> int:
        res = 0
        n = len(nums)
        for i in range(1, n - 1):
            if nums[i] == nums[i + 1]:
                nums[i] = nums[i - 1]
            left = nums[i - 1]
            right = nums[i + 1]
            if left < nums[i] and right < nums[i]:
                res += 1
            elif left > nums[i] and right > nums[i]:
                res += 1
        return res