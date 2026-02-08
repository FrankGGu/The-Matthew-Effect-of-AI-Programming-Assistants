class Solution:
    def findIncreasingSubarrays(self, nums):
        result = []
        n = len(nums)
        start = 0

        while start < n:
            end = start
            while end < n - 1 and nums[end] < nums[end + 1]:
                end += 1
            if end > start:
                result.append(nums[start:end + 1])
            start = end + 1

        return result