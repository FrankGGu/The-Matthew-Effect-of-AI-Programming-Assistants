class Solution:
    def beautifulSubarrays(self, nums: List[int]) -> int:
        count = 0
        prefix_xor = 0
        xor_counts = {0: 1}
        for num in nums:
            prefix_xor ^= num
            if prefix_xor in xor_counts:
                count += xor_counts[prefix_xor]
                xor_counts[prefix_xor] += 1
            else:
                xor_counts[prefix_xor] = 1
        return count