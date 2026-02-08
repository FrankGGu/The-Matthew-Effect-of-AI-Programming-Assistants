class Solution:
    def singleNumber(self, nums: List[int]) -> List[int]:
        xor = 0
        for num in nums:
            xor ^= num

        rightmostbit = xor & -xor

        num1 = 0
        num2 = 0

        for num in nums:
            if num & rightmostbit:
                num1 ^= num
            else:
                num2 ^= num

        return [num1, num2]