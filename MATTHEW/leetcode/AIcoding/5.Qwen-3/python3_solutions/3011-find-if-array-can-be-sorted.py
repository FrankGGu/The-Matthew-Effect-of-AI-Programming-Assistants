class Solution:
    def canBeSorted(self, nums: List[int]) -> bool:
        sorted_nums = sorted(nums)
        n = len(nums)
        for i in range(n):
            if nums[i] > nums[i + 1] if i < n - 1 else False:
                return False
        return True