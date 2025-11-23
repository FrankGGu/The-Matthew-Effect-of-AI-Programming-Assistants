class Solution:
    def maximumSum(self, nums: List[int], k: int) -> int:
        nums.sort(reverse=True)
        return sum(nums[:k])