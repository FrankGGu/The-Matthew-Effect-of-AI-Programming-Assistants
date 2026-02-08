class Solution:
    def beautifulSubarrays(self, nums: List[int]) -> int:
        prefix_xor = 0
        xor_count = {0: 1}
        res = 0

        for num in nums:
            prefix_xor ^= num
            res += xor_count.get(prefix_xor, 0)
            xor_count[prefix_xor] = xor_count.get(prefix_xor, 0) + 1

        return res