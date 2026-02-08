class Solution:
    def minOperations(self, nums: List[int]) -> int:
        nums.sort()
        n = len(nums)
        left = 0
        res = n

        for right in range(n):
            while nums[right] - nums[left] > n - 1:
                left += 1
            res = min(res, n - (right - left + 1))

        return res