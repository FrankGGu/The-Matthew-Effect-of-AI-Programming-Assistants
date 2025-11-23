class Solution:
    def smallestSubarrays(self, nums: List[int]) -> List[int]:
        n = len(nums)
        res = [1] * n
        bits = [0] * 32

        for i in range(n - 1, -1, -1):
            num = nums[i]
            for j in range(32):
                if num & (1 << j):
                    bits[j] = i
            max_bit_pos = max(bits)
            res[i] = max_bit_pos - i + 1 if max_bit_pos != 0 else 1

        return res