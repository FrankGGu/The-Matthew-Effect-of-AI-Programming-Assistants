class Solution:
    def findMaxK(self, nums: List[int]) -> int:
        num_set = set(nums)
        max_k = -1
        for num in nums:
            if num > 0 and -num in num_set:
                if num > max_k:
                    max_k = num
        return max_k