class Solution:
    def findMaxPositiveInteger(self, nums: List[int]) -> int:
        num_set = set(nums)
        result = 0
        for num in num_set:
            if num > 0 and -num in num_set:
                result = max(result, num)
        return result