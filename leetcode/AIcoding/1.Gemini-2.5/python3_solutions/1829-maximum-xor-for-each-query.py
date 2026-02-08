class Solution:
    def getMaximumXor(self, nums: list[int], maximumBit: int) -> list[int]:
        n = len(nums)

        current_xor_sum = 0
        for num in nums:
            current_xor_sum ^= num

        max_k_val = (1 << maximumBit) - 1

        result = []

        for i in range(n - 1, -1, -1):
            k = current_xor_sum ^ max_k_val
            result.append(k)

            current_xor_sum ^= nums[i]

        return result