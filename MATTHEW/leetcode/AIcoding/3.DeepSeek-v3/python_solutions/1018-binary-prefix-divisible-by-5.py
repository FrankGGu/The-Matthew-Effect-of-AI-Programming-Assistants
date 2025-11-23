class Solution:
    def prefixesDivBy5(self, nums: List[int]) -> List[bool]:
        res = []
        num = 0
        for bit in nums:
            num = (num * 2 + bit) % 5
            res.append(num == 0)
        return res