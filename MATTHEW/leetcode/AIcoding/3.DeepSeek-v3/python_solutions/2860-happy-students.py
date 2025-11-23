class Solution:
    def countWays(self, nums: List[int]) -> int:
        nums.sort()
        n = len(nums)
        ways = 0

        if nums[0] > 0:
            ways += 1

        for i in range(n - 1):
            if nums[i] < (i + 1) and nums[i + 1] > (i + 1):
                ways += 1

        if nums[-1] < n:
            ways += 1

        return ways