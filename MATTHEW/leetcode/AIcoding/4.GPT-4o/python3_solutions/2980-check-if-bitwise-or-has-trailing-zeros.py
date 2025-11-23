class Solution:
    def hasTrailingZeros(self, nums: List[int]) -> bool:
        bitwise_or = 0
        for num in nums:
            bitwise_or |= num
        return (bitwise_or & -bitwise_or) != bitwise_or