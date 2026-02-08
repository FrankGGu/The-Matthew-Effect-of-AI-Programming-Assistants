class Solution:
    def separateDigits(self, nums: List[int]) -> List[int]:
        result = []
        for num in nums:
            result.extend(int(digit) for digit in str(num))
        return result