class Solution:
    def zeroFilledSubarray(self, nums: List[int]) -> int:
        res = 0
        current = 0
        for num in nums:
            if num == 0:
                current += 1
                res += current
            else:
                current = 0
        return res