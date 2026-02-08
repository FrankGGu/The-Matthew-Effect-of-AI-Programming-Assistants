class Solution:
    def minOperations(self, nums: list[int], k: int) -> int:
        current_xor_sum = 0
        for num in nums:
            current_xor_sum ^= num

        target_xor = current_xor_sum ^ k

        operations = 0
        while target_xor > 0:
            operations += (target_xor & 1)
            target_xor >>= 1

        return operations