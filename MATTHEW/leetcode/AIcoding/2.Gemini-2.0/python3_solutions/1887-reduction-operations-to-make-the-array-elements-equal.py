class Solution:
    def reductionOperations(self, nums: List[int]) -> int:
        nums.sort()
        count = 0
        rank = 0
        for i in range(1, len(nums)):
            if nums[i] != nums[i - 1]:
                rank += 1
            count += rank
        return count