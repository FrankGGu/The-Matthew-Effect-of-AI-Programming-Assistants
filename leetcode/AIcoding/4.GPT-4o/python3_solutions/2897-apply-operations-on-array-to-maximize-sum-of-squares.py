class Solution:
    def maximizeSum(self, nums: List[int], k: int) -> int:
        nums.sort(reverse=True)
        return sum((nums[i] + j) ** 2 for i in range(k) for j in range(k))