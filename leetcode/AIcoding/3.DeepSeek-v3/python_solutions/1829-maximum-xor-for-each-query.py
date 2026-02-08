class Solution:
    def getMaximumXor(self, nums: List[int], maximumBit: int) -> List[int]:
        max_num = (1 << maximumBit) - 1
        xor_sum = 0
        result = []
        for num in nums:
            xor_sum ^= num
            result.append(xor_sum ^ max_num)
        return result[::-1]