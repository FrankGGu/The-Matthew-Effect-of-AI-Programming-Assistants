class Solution:
    def minImpossibleOR(self, nums: List[int]) -> int:
        nums_set = set(nums)
        res = 1
        while res in nums_set:
            res <<= 1
        return res