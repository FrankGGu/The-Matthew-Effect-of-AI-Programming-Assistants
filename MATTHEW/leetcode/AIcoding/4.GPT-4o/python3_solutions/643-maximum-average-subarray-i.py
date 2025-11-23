class Solution:
    def findMaxAverage(self, nums: List[int], k: int) -> float:
        return sum(nums[:k]) / k if k <= len(nums) else 0.0