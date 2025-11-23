class Solution:
    def maximumXOR(self, nums: list[int]) -> int:
        result = 0
        for num in nums:
            result |= num
        return result