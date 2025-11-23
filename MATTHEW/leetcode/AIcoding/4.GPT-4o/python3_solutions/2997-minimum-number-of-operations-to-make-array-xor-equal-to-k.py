class Solution:
    def minOperations(self, nums: List[int], K: int) -> int:
        xor_sum = 0
        for num in nums:
            xor_sum ^= num

        return 1 if xor_sum == K else 2 if (xor_sum ^ K) in nums else -1