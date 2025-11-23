class Solution:
    def separateDigits(self, nums: List[int]) -> List[int]:
        res = []
        for num in nums:
            digits = list(map(int, str(num)))
            res.extend(digits)
        return res