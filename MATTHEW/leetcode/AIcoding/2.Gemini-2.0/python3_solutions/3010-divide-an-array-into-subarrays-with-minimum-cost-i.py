class Solution:
    def minimumCost(self, nums: List[int], k: int) -> int:
        nums = nums[1:]
        nums.sort()
        return sum(nums[:k-1]) + nums[0]