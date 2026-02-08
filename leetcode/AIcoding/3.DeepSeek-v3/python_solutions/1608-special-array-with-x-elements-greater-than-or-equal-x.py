class Solution:
    def specialArray(self, nums: List[int]) -> int:
        nums.sort(reverse=True)
        n = len(nums)
        for x in range(1, n + 1):
            if x <= len(nums) and nums[x - 1] >= x and (x == n or nums[x] < x):
                return x
        return -1