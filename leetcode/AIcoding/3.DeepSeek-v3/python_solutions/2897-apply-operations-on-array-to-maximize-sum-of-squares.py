class Solution:
    def maxSumOfSquares(self, nums: List[int], k: int) -> int:
        nums.sort(reverse=True)
        n = len(nums)
        res = 0
        for i in range(k):
            res += nums[i] ** 2
            nums[i] -= 1
            if nums[i] < 0:
                nums[i] = 0
        nums.sort(reverse=True)
        for i in range(k):
            res += nums[i] ** 2
        return res