class Solution:
    def maximizeSum(self, nums: List[int], k: int) -> int:
        nums.sort(reverse=True)
        return sum(nums[i] for i in range(k))