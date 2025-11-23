class Solution:
    def countOperationsToEmptyArray(self, nums: List[int]) -> int:
        pos = {num: i for i, num in enumerate(nums)}
        sorted_nums = sorted(nums)
        res = len(nums)
        for i in range(1, len(sorted_nums)):
            if pos[sorted_nums[i]] < pos[sorted_nums[i-1]]:
                res += len(nums) - i
        return res