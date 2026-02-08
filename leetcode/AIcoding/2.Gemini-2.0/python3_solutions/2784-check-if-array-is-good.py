class Solution:
    def isGood(self, nums: List[int]) -> bool:
        n = len(nums)
        nums.sort()

        if nums[-1] != n - 1:
            return False

        for i in range(n - 2):
            if nums[i] != i + 1:
                return False

        if nums[-1] != nums[-2]:
            return False

        return True