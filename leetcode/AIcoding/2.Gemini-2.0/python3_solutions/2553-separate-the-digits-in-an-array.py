class Solution:
    def separateDigits(self, nums: List[int]) -> List[int]:
        res = []
        for num in nums:
            num_str = str(num)
            for digit in num_str:
                res.append(int(digit))
        return res