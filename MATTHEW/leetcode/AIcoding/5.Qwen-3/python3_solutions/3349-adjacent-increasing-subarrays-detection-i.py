class Solution:
    def isAdjacent(self, nums: List[int]) -> bool:
        n = len(nums)
        for i in range(n - 1):
            if nums[i + 1] != nums[i] + 1:
                return False
        return True