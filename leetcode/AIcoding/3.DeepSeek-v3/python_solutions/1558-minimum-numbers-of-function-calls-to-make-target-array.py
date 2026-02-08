class Solution:
    def minOperations(self, nums: List[int]) -> int:
        res = 0
        max_len = 0
        for num in nums:
            bits = 0
            while num > 0:
                res += num & 1
                num >>= 1
                bits += 1
            if bits > 0:
                max_len = max(max_len, bits - 1)
        return res + max_len