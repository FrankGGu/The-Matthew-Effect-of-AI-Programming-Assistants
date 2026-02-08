class Solution:
    def findIndices(self, nums: List[int]) -> List[int]:
        return [i for i in range(len(nums)) if i - nums[i] == 0]