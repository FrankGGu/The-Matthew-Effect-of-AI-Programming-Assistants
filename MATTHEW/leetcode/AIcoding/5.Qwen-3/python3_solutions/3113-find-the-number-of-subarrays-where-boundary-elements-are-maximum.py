class Solution:
    def numSubarraysWithBoundaryMax(self, nums):
        n = len(nums)
        result = 0
        for i in range(n):
            max_val = nums[i]
            for j in range(i, n):
                if nums[j] > max_val:
                    break
                if nums[j] == max_val:
                    result += 1
        return result