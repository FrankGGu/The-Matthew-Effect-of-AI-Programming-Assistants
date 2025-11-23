class Solution:
    def countWays(self, nums: List[int]) -> int:
        nums.sort()
        n = len(nums)
        count = 0
        if nums[0] > 0:
            count += 1
        for i in range(n - 1):
            if nums[i] <= i + 1 and nums[i+1] > i + 1:
                count += 1
        if nums[n-1] <= n:
            count += 1
        return count