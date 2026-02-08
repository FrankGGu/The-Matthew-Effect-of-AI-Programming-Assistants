class Solution:
    def minImpossibleOR(self, nums: List[int]) -> int:
        s = set(nums)
        res = 1
        while res in s:
            res *= 2
        return res