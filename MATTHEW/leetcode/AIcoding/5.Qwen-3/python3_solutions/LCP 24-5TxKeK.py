class Solution:
    def numberGame(self, nums: List[int]) -> List[int]:
        nums.sort()
        result = []
        for i in range(0, len(nums), 2):
            result.append(nums[i+1])
            result.append(nums[i])
        return result