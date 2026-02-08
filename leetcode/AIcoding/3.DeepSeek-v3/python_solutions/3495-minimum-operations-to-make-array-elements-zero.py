class Solution:
    def minOperations(self, nums: List[int]) -> int:
        operations = 0
        max_len = 0
        for num in nums:
            bits = 0
            while num > 0:
                operations += num & 1
                num >>= 1
                bits += 1
            max_len = max(max_len, bits)
        return operations + max_len - 1