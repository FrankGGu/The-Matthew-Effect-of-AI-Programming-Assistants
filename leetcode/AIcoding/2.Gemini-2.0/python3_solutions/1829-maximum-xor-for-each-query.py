class Solution:
    def getMaximumXor(self, nums: List[int], maximumBit: int) -> List[int]:
        max_xor = (1 << maximumBit) - 1
        prefix_xor = 0
        result = []
        for num in nums:
            prefix_xor ^= num
        for i in range(len(nums)):
            result.append(max_xor ^ prefix_xor)
            prefix_xor ^= nums[len(nums) - 1 - i]
        return result