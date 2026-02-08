class Solution:
    def reductionOperations(self, nums: List[int]) -> int:
        nums.sort()
        res = 0
        step = 0
        for i in range(1, len(nums)):
            if nums[i] != nums[i-1]:
                step += 1
            res += step
        return res