class Solution:
    def maximizeSum(self, nums: List[int], k: int) -> int:
        max_num = max(nums)
        return max_num * k + (k * (k - 1)) // 2