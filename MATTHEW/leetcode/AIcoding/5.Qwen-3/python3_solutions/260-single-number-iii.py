class Solution:
    def singleNumber(self, nums: list[int]) -> list[int]:
        xor = 0
        for num in nums:
            xor ^= num

        lowbit = xor & -xor
        a, b = 0, 0
        for num in nums:
            if num & lowbit:
                a ^= num
            else:
                b ^= num

        return [a, b]