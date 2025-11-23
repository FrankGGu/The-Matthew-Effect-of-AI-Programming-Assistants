class Solution:
    def findMaxK(self, nums: list[int]) -> int:
        s = set(nums)
        max_k = -1
        for num in nums:
            if num > 0 and -num in s:
                max_k = max(max_k, num)
        return max_k